//
//  PalmCaptureView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 5/7/26.
//

import SwiftUI
import AVFoundation

struct PalmCaptureView: View {
    @ObservedObject var viewModel: PalmReadingViewModel
    @State private var showCamera = false
    @State private var hasPermission = false
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 20) {
                if hasPermission {
                    CameraPreviewView(onCapture: { image in
                        Task {
                            await viewModel.processPalmImage(image)
                        }
                    })
                } else {
                    permissionPrompt
                }
            }
        }
        .task {
            hasPermission = await viewModel.checkCameraPermission()
        }
    }
    
    private var permissionPrompt: some View {
        VStack(spacing: 20) {
            Image(systemName: "camera.fill")
                .font(.system(size: 60))
                .foregroundColor(AppTheme.gold)
            
            Text("Camera Access Required")
                .font(AppTheme.serifFont(size: 24, weight: .medium))
                .foregroundColor(.white)
            
            Text("To read your palm, we need access to your camera. Your palm image is processed locally and never leaves your device.")
                .font(.system(size: 16))
                .foregroundColor(.white.opacity(0.8))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            Button {
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url)
                }
            } label: {
                Text("Open Settings")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.black)
                    .padding(.horizontal, 40)
                    .padding(.vertical, 16)
                    .background(AppTheme.goldGradient)
                    .cornerRadius(30)
            }
        }
    }
}

struct CameraPreviewView: UIViewControllerRepresentable {
    let onCapture: (UIImage) -> Void
    
    func makeUIViewController(context: Context) -> CameraViewController {
        let controller = CameraViewController()
        controller.onCapture = onCapture
        return controller
    }
    
    func updateUIViewController(_ uiViewController: CameraViewController, context: Context) {}
}

class CameraViewController: UIViewController {
    var onCapture: ((UIImage) -> Void)?
    
    private var captureSession: AVCaptureSession?
    private var previewLayer: AVCaptureVideoPreviewLayer?
    private var photoOutput: AVCapturePhotoOutput?
    
    private let handGuideLayer = CAShapeLayer()
    private let captureButton = UIButton(type: .system)
    private let instructionLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCamera()
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer?.frame = view.bounds
        updateHandGuidePosition()
    }
    
    private func setupCamera() {
        let session = AVCaptureSession()
        session.sessionPreset = .photo
        
        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back),
              let input = try? AVCaptureDeviceInput(device: device) else {
            return
        }
        
        if session.canAddInput(input) {
            session.addInput(input)
        }
        
        let output = AVCapturePhotoOutput()
        if session.canAddOutput(output) {
            session.addOutput(output)
            photoOutput = output
        }
        
        let preview = AVCaptureVideoPreviewLayer(session: session)
        preview.videoGravity = .resizeAspectFill
        preview.frame = view.bounds
        view.layer.insertSublayer(preview, at: 0)
        
        previewLayer = preview
        captureSession = session
        
        DispatchQueue.global(qos: .userInitiated).async {
            session.startRunning()
        }
    }
    
    private func setupUI() {
        // Hand guide overlay
        handGuideLayer.strokeColor = UIColor.systemYellow.withAlphaComponent(0.8).cgColor
        handGuideLayer.fillColor = UIColor.clear.cgColor
        handGuideLayer.lineWidth = 3
        handGuideLayer.lineDashPattern = [10, 5]
        view.layer.addSublayer(handGuideLayer)
        
        // Instruction label
        instructionLabel.text = "Place your palm within the guide"
        instructionLabel.textAlignment = .center
        instructionLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        instructionLabel.textColor = .white
        instructionLabel.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        instructionLabel.layer.cornerRadius = 10
        instructionLabel.clipsToBounds = true
        instructionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(instructionLabel)
        
        NSLayoutConstraint.activate([
            instructionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            instructionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            instructionLabel.widthAnchor.constraint(equalToConstant: 300),
            instructionLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // Capture button
        captureButton.setImage(UIImage(systemName: "circle.fill"), for: .normal)
        captureButton.tintColor = .white
        captureButton.backgroundColor = UIColor.systemYellow
        captureButton.layer.cornerRadius = 40
        captureButton.translatesAutoresizingMaskIntoConstraints = false
        captureButton.addTarget(self, action: #selector(capturePhoto), for: .touchUpInside)
        view.addSubview(captureButton)
        
        NSLayoutConstraint.activate([
            captureButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            captureButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            captureButton.widthAnchor.constraint(equalToConstant: 80),
            captureButton.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func updateHandGuidePosition() {
        let width = view.bounds.width * 0.7
        let height = width * 1.3
        let x = (view.bounds.width - width) / 2
        let y = (view.bounds.height - height) / 2
        
        let path = UIBezierPath()
        
        // Draw hand outline guide
        path.move(to: CGPoint(x: x + width * 0.5, y: y))
        
        // Thumb side
        path.addCurve(
            to: CGPoint(x: x, y: y + height * 0.7),
            controlPoint1: CGPoint(x: x + width * 0.2, y: y + height * 0.2),
            controlPoint2: CGPoint(x: x - width * 0.1, y: y + height * 0.5)
        )
        
        // Bottom of palm
        path.addCurve(
            to: CGPoint(x: x + width, y: y + height * 0.7),
            controlPoint1: CGPoint(x: x + width * 0.3, y: y + height * 0.9),
            controlPoint2: CGPoint(x: x + width * 0.7, y: y + height * 0.9)
        )
        
        // Pinky side
        path.addCurve(
            to: CGPoint(x: x + width * 0.5, y: y),
            controlPoint1: CGPoint(x: x + width * 1.1, y: y + height * 0.5),
            controlPoint2: CGPoint(x: x + width * 0.8, y: y + height * 0.2)
        )
        
        path.close()
        
        handGuideLayer.path = path.cgPath
    }
    
    @objc private func capturePhoto() {
        let settings = AVCapturePhotoSettings()
        photoOutput?.capturePhoto(with: settings, delegate: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        captureSession?.stopRunning()
    }
}

extension CameraViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation(),
              let image = UIImage(data: imageData) else {
            return
        }
        
        onCapture?(image)
    }
}

#Preview {
    PalmCaptureView(viewModel: PalmReadingViewModel())
}

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
    @State private var hasPermission = false
    // 0 = captured image fills the screen (matches the just-vanished
    //     camera preview). 1 = captured image sits at PalmReviewView's
    //     framed-thumbnail position. Animated when the photo arrives.
    @State private var shrinkProgress: CGFloat = 0

    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.black

                if !hasPermission {
                    permissionPrompt
                } else if let captured = viewModel.capturedImage {
                    captureShrinkAnimation(captured: captured, in: geo.size)
                } else {
                    CameraPreviewView(onCapture: { image in
                        // Don't kick off analysis directly — park the photo
                        // on the review screen so the user can confirm or
                        // retake before we burn time on the pipeline.
                        viewModel.setCapturedImage(image)
                    })
                }
            }
        }
        .ignoresSafeArea()
        .task {
            hasPermission = await viewModel.checkCameraPermission()
        }
    }

    // Animates the captured image from a full-screen rect down to an
    // approximation of where PalmReviewView will then display the same
    // photo. Once the spring lands, the view model flips the phase and
    // PalmReviewView's real Image takes over at that landing position.
    @ViewBuilder
    private func captureShrinkAnimation(captured: UIImage, in size: CGSize) -> some View {
        let imageAspect = max(captured.size.width / max(captured.size.height, 1), 0.001)
        let target = reviewImageFrame(in: size, imageAspect: imageAspect)
        let p = shrinkProgress

        let width = size.width + (target.width - size.width) * p
        let height = size.height + (target.height - size.height) * p
        let centerX = (size.width / 2) + (target.midX - size.width / 2) * p
        let centerY = (size.height / 2) + (target.midY - size.height / 2) * p
        let cornerRadius: CGFloat = 20 * p

        Image(uiImage: captured)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: width, height: height)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .position(x: centerX, y: centerY)
            .shadow(color: AppTheme.gold.opacity(0.25 * p), radius: 14 * p, x: 0, y: 6 * p)
            .allowsHitTesting(false)
            .onAppear {
                withAnimation(.spring(response: 0.65, dampingFraction: 0.82)) {
                    shrinkProgress = 1
                }
                Task { @MainActor in
                    try? await Task.sleep(nanoseconds: 700_000_000)
                    viewModel.completeCaptureAnimation()
                }
            }
    }

    // Approximation of where PalmReviewView's Image is laid out within
    // a full-screen rect (status bar + nav bar at the top, home indicator
    // at the bottom, title/subtitle/buttons within the VStack). Used as
    // the landing position of the shrink animation so the hand-off to
    // PalmReviewView feels visually continuous.
    private func reviewImageFrame(in size: CGSize, imageAspect: CGFloat) -> CGRect {
        let horizontalPadding: CGFloat = 24
        let topInset: CGFloat = 220   // safe area + nav bar + spacer + title + spacing + subtitle + spacing
        let bottomInset: CGFloat = 175 // spacing + buttons + bottom padding + safe area

        let availableWidth = max(size.width - 2 * horizontalPadding, 1)
        let availableHeight = max(size.height - topInset - bottomInset, 1)

        let widthFromHeight = availableHeight * imageAspect
        let heightFromWidth = availableWidth / imageAspect

        let imageWidth: CGFloat
        let imageHeight: CGFloat
        if widthFromHeight <= availableWidth {
            imageHeight = availableHeight
            imageWidth = widthFromHeight
        } else {
            imageWidth = availableWidth
            imageHeight = heightFromWidth
        }

        let x = (size.width - imageWidth) / 2
        let y = topInset + (availableHeight - imageHeight) / 2

        return CGRect(x: x, y: y, width: imageWidth, height: imageHeight)
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
        // Freeze the live preview immediately so the user gets the same
        // "shutter caught the moment" feedback as the native camera. The
        // preview connection is independent of the photo output, so the
        // photo capture itself still proceeds normally — only the preview
        // feed is paused at the last frame.
        previewLayer?.connection?.isEnabled = false
        captureButton.isEnabled = false
        captureButton.alpha = 0.5

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

        let framedImage = cropToPreviewBounds(image) ?? image
        onCapture?(framedImage)
    }

    // The preview layer uses .resizeAspectFill, so the live view crops the
    // sides (or top/bottom) of the camera feed to cover the screen. The raw
    // photo coming back from AVCapturePhotoOutput is the full sensor frame
    // and therefore contains more area than the user saw while framing.
    // We replicate the preview's aspect-fill crop on the captured image so
    // the saved photo matches what was visible behind the hand guide.
    private func cropToPreviewBounds(_ image: UIImage) -> UIImage? {
        guard let previewBounds = previewLayer?.bounds,
              previewBounds.width > 0, previewBounds.height > 0 else {
            return nil
        }

        let upright = normalizedToUp(image)
        guard let cgImage = upright.cgImage else { return nil }

        let imageW = CGFloat(cgImage.width)
        let imageH = CGFloat(cgImage.height)
        let scale = max(previewBounds.width / imageW, previewBounds.height / imageH)
        let visibleW = previewBounds.width / scale
        let visibleH = previewBounds.height / scale
        let originX = (imageW - visibleW) / 2
        let originY = (imageH - visibleH) / 2

        let cropRect = CGRect(x: originX, y: originY, width: visibleW, height: visibleH)
            .intersection(CGRect(x: 0, y: 0, width: imageW, height: imageH))
            .integral

        guard !cropRect.isNull, !cropRect.isEmpty,
              let cropped = cgImage.cropping(to: cropRect) else {
            return nil
        }

        return UIImage(cgImage: cropped, scale: upright.scale, orientation: .up)
    }

    private func normalizedToUp(_ image: UIImage) -> UIImage {
        guard image.imageOrientation != .up else { return image }
        let format = UIGraphicsImageRendererFormat.default()
        format.scale = image.scale
        let renderer = UIGraphicsImageRenderer(size: image.size, format: format)
        return renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: image.size))
        }
    }
}

#Preview {
    PalmCaptureView(viewModel: PalmReadingViewModel())
}

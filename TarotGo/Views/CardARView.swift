//
//  CardARView.swift
//  TarotGo
//
//  AR view for displaying tarot cards in augmented reality
//

import SwiftUI
import RealityKit
import ARKit

struct CardARView: View {
    let card: TarotCard
    @State private var showReversed: Bool = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            // AR View
            ARViewContainer(card: card, showReversed: $showReversed)
                .ignoresSafeArea()
            
            // Controls overlay
            VStack {
                // Top bar with close button
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 32))
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.3), radius: 5)
                    }
                    .padding()
                    
                    Spacer()
                }
                
                Spacer()
                
                // Bottom controls
                VStack(spacing: 16) {
                    // Card name
                    Text(card.localizedName)
                        .font(AppTheme.serifFont(size: 24, weight: .medium))
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.5), radius: 5)
                    
                    // Flip button
                    Button {
                        withAnimation {
                            showReversed.toggle()
                        }
                    } label: {
                        HStack(spacing: 8) {
                            Image(systemName: "arrow.triangle.2.circlepath")
                                .font(.system(size: 18))
                            Text(showReversed ? L10n.dictionaryUpright : L10n.dictionaryReversed)
                                .font(.system(size: 16, weight: .semibold))
                        }
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                        .background(
                            Capsule()
                                .fill(.ultraThinMaterial)
                        )
                        .foregroundColor(.white)
                    }
                }
                .padding(.bottom, 40)
            }
        }
        .navigationBarHidden(true)
    }
}

// ARViewContainer to manage the RealityKit AR experience
struct ARViewContainer: UIViewRepresentable {
    let card: TarotCard
    @Binding var showReversed: Bool
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        // Configure AR session
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical]
        arView.session.run(config)
        
        // Create the card in AR space
        context.coordinator.createCard(in: arView, card: card, isReversed: showReversed)
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        // Update card rotation when showReversed changes
        context.coordinator.updateCardOrientation(isReversed: showReversed)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(card: card)
    }
    
    class Coordinator {
        let card: TarotCard
        var cardEntity: ModelEntity?
        var cardAnchor: AnchorEntity?
        
        init(card: TarotCard) {
            self.card = card
        }
        
        func createCard(in arView: ARView, card: TarotCard, isReversed: Bool) {
            // 1. Position: 0.5 meters away (not 1.5) and at eye level (0 height)
            let anchor = AnchorEntity(world: [0, 0, -0.5])
            
            // 2. Realistic Size: 15cm height (0.15m)
            let cardAspectRatio: Float = 1108.0 / 1900.0
            let cardHeight: Float = 0.15
            let cardWidth: Float = cardHeight * cardAspectRatio
            
            // 3. Use a Plane instead of a Box for the front
            // A plane only has one side, making it much harder to "get lost" inside it
            let mesh = MeshResource.generatePlane(width: cardWidth, height: cardHeight)
            
            // 4. Use UnlitMaterial (This ignores light and shows the raw image)
            var material = UnlitMaterial()
            
            if let frontImage = UIImage(named: card.imageName),
               let cgImage = frontImage.cgImage,
               let texture = try? TextureResource.generate(from: cgImage, options: .init(semantic: .color)) {
                material.color = .init(texture: .init(texture))
            } else {
                // If the image fails, this pink will be very obvious
                material.color = .init(tint: .systemPink)
            }
            
            let cardEntity = ModelEntity(mesh: mesh, materials: [material])
            
            // 5. Correct Orientation
            // Planes are generated lying flat on the ground (X-Z plane).
            // We need to tilt it up 90 degrees to face the user.
            //cardEntity.orientation = simd_quatf(angle: .pi/2, axis: [1, 0, 0])
            
            if isReversed {
                cardEntity.orientation *= simd_quatf(angle: .pi, axis: [0, 0, 1])
            }
            
            anchor.addChild(cardEntity)
            arView.scene.addAnchor(anchor)
            
            self.cardEntity = cardEntity
            self.cardAnchor = anchor
        }
        
        func updateCardOrientation(isReversed: Bool) {
            guard let entity = cardEntity else { return }
            
            // Match the same axis used in createCard (Z axis)
            let targetRotation = isReversed
                ? simd_quatf(angle: .pi, axis: [0, 0, 1])
                : simd_quatf(angle: 0, axis: [0, 0, 1])
            
            var transform = entity.transform
            transform.rotation = targetRotation
            
            entity.move(to: transform, relativeTo: entity.parent, duration: 0.6)
        }
    }
}

#Preview {
    CardARView(card: TarotDeck.allCards[0])
}

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
        var cardEntity: Entity?
        var cardAnchor: AnchorEntity?
        
        init(card: TarotCard) {
            self.card = card
        }
        
        func createCard(in arView: ARView, card: TarotCard, isReversed: Bool) {
            // Anchor
            let anchor = AnchorEntity(world: [0, 0, -0.5])
            
            // Size (realistic)
            let cardHeight: Float = 1
            let cardAspectRatio: Float = 1108.0 / 1900.0
            let cardWidth: Float = cardHeight * cardAspectRatio
            
            // MARK: - Materials
            
            // Front
            var frontMaterial = UnlitMaterial()
            if let frontImage = UIImage(named: card.imageName),
               let cg = frontImage.cgImage,
               let texture = try? TextureResource.generate(
                   from: cg,
                   options: .init(semantic: .color)
               ) {
                frontMaterial.color = .init(texture: .init(texture))
            } else {
                frontMaterial.color = .init(tint: .systemPink)
            }
            
            // Back
            var backMaterial = UnlitMaterial()
            if let backImage = UIImage(named: "ReversCard1"),
               let cg = backImage.cgImage,
               let texture = try? TextureResource.generate(
                   from: cg,
                   options: .init(semantic: .color)
               ) {
                backMaterial.color = .init(texture: .init(texture))
            } else {
                backMaterial.color = .init(tint: .systemPurple)
            }
            
            // MARK: - Mesh (2 planes)
            
            let frontMesh = MeshResource.generatePlane(width: cardWidth, height: cardHeight)
            let backMesh  = MeshResource.generatePlane(width: cardWidth, height: cardHeight)
            
            let frontEntity = ModelEntity(mesh: frontMesh, materials: [frontMaterial])
            let backEntity  = ModelEntity(mesh: backMesh,  materials: [backMaterial])
            
            // Flip back so it faces opposite direction
            backEntity.orientation = simd_quatf(angle: .pi, axis: [0, 1, 0])
            
            // Small offset to avoid z-fighting
            frontEntity.position.z = 0.0005
            backEntity.position.z  = -0.0005
            
            // Parent container
            let cardEntity = Entity()
            cardEntity.addChild(frontEntity)
            cardEntity.addChild(backEntity)
            
            // Initial orientation
            if isReversed {
                cardEntity.orientation = simd_quatf(angle: .pi, axis: [0, 1, 0])
            }
            
            // Add to scene
            anchor.addChild(cardEntity)
            arView.scene.addAnchor(anchor)
            
            self.cardEntity = cardEntity as? ModelEntity
            self.cardAnchor = anchor
        }
        
        func updateCardOrientation(isReversed: Bool) {
            guard let entity = cardEntity else { return }
            
            let targetRotation = isReversed
                ? simd_quatf(angle: .pi, axis: [0, 1, 0])
                : simd_quatf(angle: 0, axis: [0, 1, 0])
            
            var transform = Transform()
            transform.rotation = targetRotation
            transform.translation = entity.position // preserve position
            
            entity.move(to: transform, relativeTo: entity.parent, duration: 0.6)
        }
    }
}

#Preview {
    CardARView(card: TarotDeck.allCards[0])
}

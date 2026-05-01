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
            // Create anchor 1.5 meters in front of the user
            let anchor = AnchorEntity(world: [0, 0, -1.5])
            
            // Card dimensions: 2m height, maintaining aspect ratio
            let cardAspectRatio: Float = 1108.0 / 1900.0
            let cardHeight: Float = 2.0
            let cardWidth: Float = cardHeight * cardAspectRatio
            let cardThickness: Float = 0.01
            
            // Create a box mesh for the card
            let mesh = MeshResource.generateBox(
                width: cardWidth,
                height: cardHeight,
                depth: cardThickness
            )
            
            // Create materials for front and back
            var materials: [RealityKit.Material] = []
            
            // Front material (card image)
            if let frontImage = UIImage(named: card.imageName), let cgImage = frontImage.cgImage {
                var frontMaterial = SimpleMaterial()
                if let texture = try? TextureResource.generate(from: cgImage, options: .init(semantic: .color)) {
                    frontMaterial.color = .init(texture: .init(texture))
                }
                materials.append(frontMaterial)
            } else {
                // Fallback material
                var fallbackMaterial = SimpleMaterial()
                fallbackMaterial.color = .init(tint: .purple)
                materials.append(fallbackMaterial)
            }
            
            // Get selected card back style
            let selectedCardBackRaw = UserDefaults.standard.string(forKey: "selectedCardBack") ?? "card_back_modern"
            
            // Back material (card back)
            if let backImage = UIImage(named: selectedCardBackRaw), let cgImage = backImage.cgImage {
                var backMaterial = SimpleMaterial()
                if let texture = try? TextureResource.generate(from: cgImage, options: .init(semantic: .color)) {
                    backMaterial.color = .init(texture: .init(texture))
                }
                materials.append(backMaterial)
            } else {
                // Fallback material
                var fallbackMaterial = SimpleMaterial()
                fallbackMaterial.color = .init(tint: .blue)
                materials.append(fallbackMaterial)
            }
            
            // Create edge materials (same color for all edges)
            var edgeMaterial = SimpleMaterial()
            edgeMaterial.color = .init(tint: .init(white: 0.9, alpha: 1.0))
            
            // Apply materials to all faces of the box
            // Box faces: +X, -X, +Y, -Y, +Z, -Z
            // We want: front (+Z), back (-Z), and edges (others)
            let allMaterials = [
                edgeMaterial,  // +X (right edge)
                edgeMaterial,  // -X (left edge)
                edgeMaterial,  // +Y (top edge)
                edgeMaterial,  // -Y (bottom edge)
                materials[0],  // +Z (front - card image)
                materials.count > 1 ? materials[1] : materials[0]  // -Z (back)
            ]
            
            // Create the card entity
            let cardEntity = ModelEntity(mesh: mesh, materials: allMaterials)
            
            // Apply initial rotation if reversed
            if isReversed {
                cardEntity.transform.rotation = simd_quatf(angle: .pi, axis: [0, 1, 0])
            }
            
            // Add to anchor
            anchor.addChild(cardEntity)
            
            // Add anchor to scene
            arView.scene.addAnchor(anchor)
            
            // Store references
            self.cardEntity = cardEntity
            self.cardAnchor = anchor
        }
        
        func updateCardOrientation(isReversed: Bool) {
            guard let entity = cardEntity else { return }
            
            // Animate the rotation
            let targetRotation = isReversed ? simd_quatf(angle: .pi, axis: [0, 1, 0]) : simd_quatf(angle: 0, axis: [0, 1, 0])
            
            var transform = entity.transform
            transform.rotation = targetRotation
            
            entity.move(to: transform, relativeTo: entity.parent, duration: 0.6)
        }
    }
}

#Preview {
    CardARView(card: TarotDeck.allCards[0])
}

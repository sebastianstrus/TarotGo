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
    @State private var isFlipped: Bool = false
    @State private var showReversed: Bool = false
    @AppStorage("selectedCardBack") private var selectedCardBackRaw: String = CardBackStyle.modern.rawValue
    @Environment(\.dismiss) private var dismiss
    
    private var selectedCardBack: CardBackStyle {
        CardBackStyle(rawValue: selectedCardBackRaw) ?? .modern
    }
    
    var body: some View {
        ZStack {
            // AR View
            ARViewContainer(card: card, isFlipped: $isFlipped, showReversed: $showReversed, cardBackStyle: selectedCardBack)
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
                    
                    HStack(spacing: 16) {
                        // Flip button (show front/back)
                        Button {
                            withAnimation {
                                isFlipped.toggle()
                            }
                        } label: {
                            HStack(spacing: 8) {
                                Image(systemName: "arrow.triangle.2.circlepath")
                                    .font(.system(size: 18))
                                Text("Flip")
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
                        
                        // Reversed/Upright button (rotate 180°)
                        Button {
                            withAnimation {
                                showReversed.toggle()
                            }
                        } label: {
                            HStack(spacing: 8) {
                                Image(systemName: "arrow.up.arrow.down")
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
    @Binding var isFlipped: Bool
    @Binding var showReversed: Bool
    let cardBackStyle: CardBackStyle
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        // Configure AR session
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical]
        arView.session.run(config)
        
        // Create the card in AR space
        context.coordinator.createCard(in: arView, card: card, isFlipped: isFlipped, isReversed: showReversed, cardBackStyle: cardBackStyle)
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        // Update card rotation when isFlipped or showReversed changes
        context.coordinator.updateCardOrientation(isFlipped: isFlipped, isReversed: showReversed)
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
        
        func createCard(in arView: ARView, card: TarotCard, isFlipped: Bool, isReversed: Bool, cardBackStyle: CardBackStyle) {
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
            if let backImage = UIImage(named: cardBackStyle.rawValue),
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
            
            // Initial orientation - combine flip and reversed rotations
            let flipRotation = simd_quatf(angle: isFlipped ? .pi : 0, axis: [0, 1, 0])
            let reversedRotation = simd_quatf(angle: isReversed ? .pi : 0, axis: [0, 0, 1])
            cardEntity.orientation = flipRotation * reversedRotation
            
            // Add to scene
            anchor.addChild(cardEntity)
            arView.scene.addAnchor(anchor)
            
            self.cardEntity = cardEntity
            self.cardAnchor = anchor
        }
        
        func updateCardOrientation(isFlipped: Bool, isReversed: Bool) {
            guard let entity = cardEntity else { return }
            
            // Combine both rotations:
            // - Flip rotates around Y-axis (to show back)
            // - Reversed rotates around Z-axis (to show upside down)
            let flipRotation = simd_quatf(angle: isFlipped ? .pi : 0, axis: [0, 1, 0])
            let reversedRotation = simd_quatf(angle: isReversed ? .pi : 0, axis: [0, 0, 1])
            let combinedRotation = flipRotation * reversedRotation
            
            entity.move(
                to: Transform(
                    scale: .one,
                    rotation: combinedRotation,
                    translation: entity.position
                ),
                relativeTo: entity.parent,
                duration: 0.6,
                timingFunction: .easeInOut
            )
        }
    }
}

#Preview {
    CardARView(card: TarotDeck.allCards[0])
}

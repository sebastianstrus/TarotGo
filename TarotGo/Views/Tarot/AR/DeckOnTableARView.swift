//
//  DeckOnTableARView.swift
//  TarotGo
//
//  AR view displaying all 78 tarot cards lying flat on a table
//

import SwiftUI
import RealityKit
import ARKit

struct DeckOnTableARView: View {
    let cardBackStyle: CardBackStyle
    @State private var isFlipped: Bool = false
    
    var body: some View {
        ZStack {
            DeckOnTableARContainer(cardBackStyle: cardBackStyle, isFlipped: $isFlipped)
                .ignoresSafeArea()
            
            // Flip button overlay
            VStack {
                Spacer()
                
                Button {
                    withAnimation {
                        isFlipped.toggle()
                    }
                } label: {
                    HStack(spacing: 8) {
                        Image(systemName: "arrow.triangle.2.circlepath")
                            .font(.system(size: 18))
                        Text("Flip All")
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
                .padding(.bottom, 40)
            }
        }
    }
}

struct DeckOnTableARContainer: UIViewRepresentable {
    let cardBackStyle: CardBackStyle
    @Binding var isFlipped: Bool
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        // 1. Disable the default environment lighting/shadows
        arView.environment.lighting.resource = nil
        
        // 2. Explicitly disable grounding shadows
        arView.renderOptions.insert(.disableGroundingShadows)
        
        // Configure AR session
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal]
        
        if ARWorldTrackingConfiguration.supportsFrameSemantics(.personSegmentationWithDepth) {
            config.frameSemantics.insert(.personSegmentationWithDepth)
        } else {
            print("People Occlusion is not supported on this device.")
        }
        
        arView.session.run(config)
        
        // Set delegate to detect planes
        arView.session.delegate = context.coordinator
        context.coordinator.arView = arView
        context.coordinator.cardBackStyle = cardBackStyle
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        // Update flip state
        context.coordinator.updateFlipState(isFlipped: isFlipped)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject, ARSessionDelegate {
        var arView: ARView?
        var cardBackStyle: CardBackStyle = .modern
        var hasPlacedCards = false
        var cardEntities: [Entity] = []
        
        func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
            guard !hasPlacedCards else { return }
            
            // Look for the first horizontal plane
            for anchor in anchors {
                if let planeAnchor = anchor as? ARPlaneAnchor,
                   planeAnchor.alignment == .horizontal,
                   let arView = arView {
                    hasPlacedCards = true
                    createDeckOnTable(on: planeAnchor, in: arView, cardBackStyle: cardBackStyle)
                    break
                }
            }
        }
        
        func updateFlipState(isFlipped: Bool) {
            for cardEntity in cardEntities {
                // Base rotation to lie flat on surface (X-axis rotation)
                let baseRotation = simd_quatf(angle: .pi / 2, axis: [1, 0, 0])
                // Flip rotation around Y-axis to reveal front/back
                let flipRotation = simd_quatf(angle: isFlipped ? .pi : 0, axis: [0, 1, 0])
                // Combine: first flip, then lay flat
                let combinedRotation = baseRotation * flipRotation
                
                cardEntity.move(
                    to: Transform(
                        scale: .one,
                        rotation: combinedRotation,
                        translation: cardEntity.position
                    ),
                    relativeTo: cardEntity.parent,
                    duration: 0.6,
                    timingFunction: .easeInOut
                )
            }
        }
        
        func createDeckOnTable(on planeAnchor: ARPlaneAnchor, in arView: ARView, cardBackStyle: CardBackStyle) {
            // Create anchor at the detected plane's position
            let anchor = AnchorEntity(anchor: planeAnchor)
            
            // Real card size (in meters) - 3 times smaller
            let cardHeight: Float = 0.06
            let cardWidth: Float = 0.03495
            
            // Layout: Grid arrangement on table
            let allCards = TarotDeck.allCards
            let columns = 13
            let rows = 6
            
            let cardSpacing: Float = 0.003
            
            let totalWidth = Float(columns) * (cardWidth + cardSpacing)
            let totalDepth = Float(rows) * (cardHeight + cardSpacing)
            
            // Center the grid
            let startX = -totalWidth / 2
            let startZ = -totalDepth / 2
            
            for (index, card) in allCards.enumerated() {
                let row = index / columns
                let col = index % columns
                
                let x = startX + Float(col) * (cardWidth + cardSpacing) + cardWidth / 2
                let z = startZ + Float(row) * (cardHeight + cardSpacing) + cardHeight / 2
                
                if let cardEntity = createCardEntity(
                    card: card,
                    cardBackStyle: cardBackStyle,
                    width: cardWidth,
                    height: cardHeight
                ) {
                    cardEntity.position = SIMD3(x: x, y: 0.001, z: z)
                    cardEntity.orientation = simd_quatf(angle: .pi / 2, axis: [1, 0, 0])
                    
                    anchor.addChild(cardEntity)
                    self.cardEntities.append(cardEntity)
                }
            }
            
            arView.scene.addAnchor(anchor)
        }
        
        private func createCardEntity(
            card: TarotCard,
            cardBackStyle: CardBackStyle,
            width: Float,
            height: Float
        ) -> Entity? {
            // Front material
            var frontMaterial = UnlitMaterial()
            if let frontImage = UIImage(named: card.imageName),
               let cg = frontImage.cgImage,
               let texture = try? TextureResource.generate(
                   from: cg,
                   options: .init(semantic: .color)
               ) {
                frontMaterial.color = .init(texture: .init(texture))
            } else {
                return nil
            }
            
            // Back material
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
            
            // Create meshes
            let frontMesh = MeshResource.generatePlane(width: width, height: height)
            let backMesh = MeshResource.generatePlane(width: width, height: height)
            
            let frontEntity = ModelEntity(mesh: frontMesh, materials: [frontMaterial])
            let backEntity = ModelEntity(mesh: backMesh, materials: [backMaterial])
            
            // Flip back so it faces opposite direction
            backEntity.orientation = simd_quatf(angle: .pi, axis: [0, 1, 0])
            
            // Small offset to avoid z-fighting
            frontEntity.position.z = 0.0005
            backEntity.position.z = -0.0005
            
            // Parent container
            let cardEntity = Entity()
            cardEntity.addChild(frontEntity)
            cardEntity.addChild(backEntity)
            
            return cardEntity
        }
    }
}

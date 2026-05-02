//
//  TarotParkARView.swift
//  TarotGo
//
//  AR view displaying all 78 tarot cards in a park-like setting
//

import SwiftUI
import RealityKit
import ARKit

struct TarotParkARView: UIViewRepresentable {
    let cardBackStyle: CardBackStyle
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        // Configure AR session
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal]
        arView.session.run(config)
        
        // Set delegate to detect planes
        arView.session.delegate = context.coordinator
        context.coordinator.arView = arView
        context.coordinator.cardBackStyle = cardBackStyle
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        // No updates needed
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject, ARSessionDelegate {
        var arView: ARView?
        var cardBackStyle: CardBackStyle = .modern
        var hasPlacedCards = false
        
        func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
            guard !hasPlacedCards else { return }
            
            // Look for the first horizontal plane
            for anchor in anchors {
                if let planeAnchor = anchor as? ARPlaneAnchor,
                   planeAnchor.alignment == .horizontal,
                   let arView = arView {
                    hasPlacedCards = true
                    createTarotPark(on: planeAnchor, in: arView, cardBackStyle: cardBackStyle)
                    break
                }
            }
        }
        
        func createTarotPark(on planeAnchor: ARPlaneAnchor, in arView: ARView, cardBackStyle: CardBackStyle) {
            let anchor = AnchorEntity(anchor: planeAnchor)
            
            // --- LARGE CARD CONFIGURATION ---
            let cardHeight: Float = 1.0 // 1 meter tall
            let cardAspectRatio: Float = 1108.0 / 1900.0
            let cardWidth: Float = cardHeight * cardAspectRatio
            
            // --- PATHWAY LAYOUT CONFIGURATION ---
            let allCards = TarotDeck.allCards
            let columns = 6  // Fewer columns makes the "walkway" longer
            let rows = 13    // 6 * 13 = 78 cards
            
            // Spacing: 1.5 meters between card centers provides a clear walking path
            let horizontalSpacing: Float = 1.5
            let depthSpacing: Float = 1.5
            
            let totalWidth = Float(columns - 1) * horizontalSpacing
            let totalDepth = Float(rows - 1) * depthSpacing
            
            // Center the park relative to where the plane was detected
            let startX = -totalWidth / 2
            let startZ = -totalDepth / 2
            
            for (index, card) in allCards.enumerated() {
                let row = index / columns
                let col = index % columns
                
                let x = startX + Float(col) * horizontalSpacing
                let z = startZ + Float(row) * depthSpacing
                
                if let cardEntity = createCardEntity(
                    card: card,
                    cardBackStyle: cardBackStyle,
                    width: cardWidth,
                    height: cardHeight
                ) {
                    cardEntity.position = SIMD3(x: x, y: cardHeight / 2, z: z)

                    cardEntity.orientation = simd_quatf(angle: 0, axis: [0, 1, 0])
                    
                    anchor.addChild(cardEntity)
                }
            }
            
            // Optimization: Disable shadows to keep the "Park" look clean as requested previously
            arView.renderOptions.insert(.disableGroundingShadows)
            arView.environment.lighting.resource = nil
            
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

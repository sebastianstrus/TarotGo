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
        
        // Create all 78 cards in the park layout
        context.coordinator.createTarotPark(in: arView, cardBackStyle: cardBackStyle)
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        // No updates needed
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator {
        func createTarotPark(in arView: ARView, cardBackStyle: CardBackStyle) {
            // Anchor point
            let anchor = AnchorEntity(world: [0, 0, -1])
            
            // Card size (same as CardARView - large size)
            let cardHeight: Float = 1.0
            let cardAspectRatio: Float = 1108.0 / 1900.0
            let cardWidth: Float = cardHeight * cardAspectRatio
            
            // Layout: Create a circular park arrangement
            let allCards = TarotDeck.allCards
            let totalCards = allCards.count
            let radius: Float = 5.0 // 5 meters radius
            
            for (index, card) in allCards.enumerated() {
                let angle = Float(index) * (2 * .pi / Float(totalCards))
                let x = radius * cos(angle)
                let z = radius * sin(angle)
                
                // Create card entity
                if let cardEntity = createCardEntity(
                    card: card,
                    cardBackStyle: cardBackStyle,
                    width: cardWidth,
                    height: cardHeight
                ) {
                    // Position on horizontal plane
                    cardEntity.position = SIMD3(x: x, y: 0, z: z)
                    
                    // Rotate card to face center of circle
                    let rotationAngle = angle + .pi / 2
                    cardEntity.orientation = simd_quatf(angle: rotationAngle, axis: [0, 1, 0])
                    
                    anchor.addChild(cardEntity)
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

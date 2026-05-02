//
//  DeckOnTableARView.swift
//  TarotGo
//
//  AR view displaying all 78 tarot cards lying flat on a table
//

import SwiftUI
import RealityKit
import ARKit

struct DeckOnTableARView: UIViewRepresentable {
    let cardBackStyle: CardBackStyle
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        
        // Configure AR session
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal]
        arView.session.run(config)
        
        // Create all 78 cards on table
        context.coordinator.createDeckOnTable(in: arView, cardBackStyle: cardBackStyle)
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        // No updates needed
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator {
        func createDeckOnTable(in arView: ARView, cardBackStyle: CardBackStyle) {
            // Anchor point
            let anchor = AnchorEntity(world: [0, 0, -0.5])
            
            // Real card size (in meters)
            // Standard tarot card: 70mm x 120mm = 0.07m x 0.12m
            let cardHeight: Float = 0.12
            let cardWidth: Float = 0.07
            
            // Layout: Grid arrangement on table
            let allCards = TarotDeck.allCards
            let columns = 13 // 13 columns (one for each rank)
            let rows = 6 // 6 rows (Major Arcana + 4 suits + extra)
            
            let cardSpacing: Float = 0.01 // 1cm spacing between cards
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
                
                // Create card entity
                if let cardEntity = createCardEntity(
                    card: card,
                    cardBackStyle: cardBackStyle,
                    width: cardWidth,
                    height: cardHeight
                ) {
                    // Position on horizontal plane, lying flat
                    cardEntity.position = SIMD3(x: x, y: 0, z: z)
                    
                    // Rotate card to lie flat on the surface
                    cardEntity.orientation = simd_quatf(angle: .pi / 2, axis: [1, 0, 0])
                    
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

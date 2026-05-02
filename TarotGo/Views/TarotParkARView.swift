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
        
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal]
        
        if ARWorldTrackingConfiguration.supportsFrameSemantics(.personSegmentationWithDepth) {
            config.frameSemantics.insert(.personSegmentationWithDepth)
        } else {
            print("People Occlusion is not supported on this device.")
        }
        
        arView.session.run(config)
        
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
            
            let cardHeight: Float = 1.0 // 1 meter tall
            let cardAspectRatio: Float = 1108.0 / 1900.0
            let cardWidth: Float = cardHeight * cardAspectRatio
            
            let allCards = TarotDeck.allCards
            let columns = 6
            let rows = 13
            
            let horizontalSpacing: Float = 1.0
            let depthSpacing: Float = 0.7
            
            let floorOffset: Float = 0.5
            
            let totalWidth = Float(columns - 1) * horizontalSpacing
            let totalDepth = Float(rows - 1) * depthSpacing
            
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
                    let yPosition = (cardHeight / 2) + floorOffset
                    cardEntity.position = SIMD3(x: x, y: yPosition, z: z)

                    cardEntity.orientation = simd_quatf(angle: 0, axis: [0, 1, 0])
                    
                    anchor.addChild(cardEntity)
                }
            }
            
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
            let thickness: Float = 0.02
            let cornerRadius: Float = width * 0.06
            
            let cardMesh = MeshResource.generateBox(
                width: width,
                height: height,
                depth: thickness,
                cornerRadius: cornerRadius,
                splitFaces: true
            )
            
            var frontMaterial = UnlitMaterial()
            if let frontImage = UIImage(named: card.imageName),
               let cg = frontImage.cgImage,
               let texture = try? TextureResource.generate(from: cg, options: .init(semantic: .color)) {
                frontMaterial.color = .init(texture: .init(texture))
            } else {
                return nil
            }
            
            var backMaterial = UnlitMaterial()
            if let backImage = UIImage(named: cardBackStyle.rawValue),
               let cg = backImage.cgImage,
               let texture = try? TextureResource.generate(from: cg, options: .init(semantic: .color)) {
                backMaterial.color = .init(texture: .init(texture))
            } else {
                backMaterial.color = .init(tint: .darkGray)
            }
            
            var sideMaterial = UnlitMaterial()
            sideMaterial.color = .init(tint: .white)

            let cardEntity = ModelEntity(
                mesh: cardMesh,
                materials: [frontMaterial, backMaterial, sideMaterial, sideMaterial, sideMaterial, sideMaterial]
            )
            
            return cardEntity
        }
    }
}

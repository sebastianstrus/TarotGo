//
//  AnimatedBackgroundView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 4/12/26.
//

import SwiftUI
import Vortex

struct AnimatedBackgroundView: View {
    var body: some View {
        ZStack {
            Image("sky_background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

//            VortexView(VortexSystem.sharedFog) {
//                RadialGradient(
//                    colors: [.gray.opacity(1.0), .gray.opacity(0)],
//                    center: .center,
//                    startRadius: 0,
//                    endRadius: 80
//                )
//                .frame(width: 120, height: 120)
//                .blur(radius: 5)
//                .tag("circle")
//            }
//            .ignoresSafeArea()
//            .allowsHitTesting(false)
        }
    }
}

// MARK: - Fog Vortex System

extension VortexSystem {
    /// Shared fog instance so particle state (drift position, age, etc.)
    /// persists across view recreations when switching tabs or navigating.
    /// A dense, slow-drifting fog that covers the full screen.
    static let sharedFog: VortexSystem = VortexSystem(
        tags: ["circle"],
        position: [0.5, 1.15],
        shape: .box(width: 1.2, height: 0.1),
        birthRate: 8,
        lifespan: 40,
        lifespanVariation: 10,
        speed: 0.001,
        speedVariation: 0.001,
        angle: .degrees(0),
        angleRange: .degrees(40),
        acceleration: [0, -0.01],
        angularSpeed: [0, 0, 0.16],
        angularSpeedVariation: [0, 0, 0.2],
        colors: .ramp(
            .gray.opacity(0.5),
            .gray.opacity(0.7),
            .gray.opacity(0.65),
            .gray.opacity(0)
        ),
        size: 1.0,
        sizeVariation: 0.6,
        sizeMultiplierAtDeath: 2.6,
        stretchFactor: 1.6
    )
}

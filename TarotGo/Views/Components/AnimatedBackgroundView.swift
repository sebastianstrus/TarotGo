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

            VortexView(.fog) {
                RadialGradient(
                    colors: [.gray.opacity(1.0), .gray.opacity(0)],
                    center: .center,
                    startRadius: 0,
                    endRadius: 80
                )
                .frame(width: 180, height: 180)
                .blur(radius: 8)
                .tag("circle")
            }
            .ignoresSafeArea()
            .allowsHitTesting(false)
        }
    }
}

// MARK: - Fog Vortex System

extension VortexSystem {
    /// A dense, slow-drifting fog that covers the full screen.
    /// Distinct, swirling gray smoke plumes that rise and drift.
    static var fog: VortexSystem {
        VortexSystem(
            tags: ["circle"],
            position: [0.5, 1.15],
            shape: .box(width: 1.2, height: 0.1),
            birthRate: 18,
            lifespan: 105,
            lifespanVariation: 30,
            speed: 0.02,
            speedVariation: 0.01,
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
}

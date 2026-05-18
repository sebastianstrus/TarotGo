//
//  MainButtonStyle.swift
//  TarotGo
//
//  Created by Sebastian Strus on 5/18/26.
//

import SwiftUI

struct MainButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .opacity(configuration.isPressed ? 0.9 : 1.0)
            .animation(.spring(response: 0.3), value: configuration.isPressed)
            .onChange(of: configuration.isPressed) { oldValue, newValue in
                if newValue {
                    SoundService.shared.play(.whoosh, volume: 0.4)
                    HapticService.shared.impact(.light)
                }
            }
    }
}

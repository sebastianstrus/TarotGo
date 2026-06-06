//
//  AnimatedBackgroundView.swift
//  TarotGo
//
//  Created by Sebastian Strus on 4/12/26.
//

import SwiftUI

struct AnimatedBackgroundView: View {
    var body: some View {
        Image("sky_background")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
    }
}

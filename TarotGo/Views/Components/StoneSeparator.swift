//
//  StoneSeparator.swift
//  TarotGo
//

import SwiftUI

/// A horizontal separator built from stone pieces: a left end, as many middle pieces as the
/// available width requires, and a right end. All pieces share the same height.
struct StoneSeparator: View {
    var height: CGFloat = 20

    // Pixel sizes of the source images (all 79 px tall)
    private let endAspect: CGFloat = 90.0 / 79.0
    private let middleAspect: CGFloat = 120.0 / 79.0

    var body: some View {
        GeometryReader { proxy in
            let endWidth = height * endAspect
            let remaining = max(proxy.size.width - 2 * endWidth, 0)
            // Use as many middle pieces as fit, then stretch them slightly so the row is filled exactly
            let middleCount = max(Int((remaining / (height * middleAspect)).rounded()), 0)
            let middleWidth = middleCount > 0 ? remaining / CGFloat(middleCount) : 0

            HStack(spacing: 0) {
                Image("separator_left")
                    .resizable()
                    .frame(width: endWidth, height: height)
                ForEach(0..<middleCount, id: \.self) { _ in
                    Image("separator_middle")
                        .resizable()
                        .frame(width: middleWidth, height: height)
                }
                Image("separator_right")
                    .resizable()
                    .frame(width: endWidth, height: height)
            }
            .frame(width: proxy.size.width, height: height)
        }
        .frame(height: height)
        .accessibilityHidden(true)
    }
}

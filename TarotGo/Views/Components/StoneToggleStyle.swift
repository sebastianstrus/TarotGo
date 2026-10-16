import SwiftUI

/// A toggle style where an inner stone slides horizontally inside an outer stone frame.
struct StoneToggleStyle: ToggleStyle {
    private let width: CGFloat = 84
    private let height: CGFloat = 31
    private let inset: CGFloat = 5
    /// Glow rectangle size relative to the inner stone.
    private let glowScale: CGFloat = 0.7

    /// Inner stone size, keeping the image's aspect ratio (178 x 80).
    private var stoneSize: CGSize {
        let stoneHeight = height - inset * 2 - 2
        return CGSize(width: stoneHeight * 178 / 80, height: stoneHeight)
    }

    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            ZStack {
                Image("stone_outside")
                    .resizable()
                    .frame(width: width, height: height)

                // Gold glow sitting in the stone's "off" slot. It is hidden behind the stone
                // when off and revealed when the stone slides away. Clipped to the trough.
                HStack {
                    // Soft gold light: blurred layers with no hard edges, brightest in the center
                    ZStack {
                        // Wide, dim halo
                        RoundedRectangle(cornerRadius: 4)
                            .fill(AppTheme.gold.opacity(0.5))
                            .frame(width: stoneSize.width * glowScale, height: stoneSize.height * glowScale)
                            .blur(radius: 6)
                        // Medium glow
                        RoundedRectangle(cornerRadius: 4)
                            .fill(AppTheme.gold.opacity(0.8))
                            .frame(width: stoneSize.width * glowScale * 0.75, height: stoneSize.height * glowScale * 0.7)
                            .blur(radius: 3.5)
                        // Hot core
                        RoundedRectangle(cornerRadius: 3)
                            .fill(Color.white.opacity(0.55))
                            .frame(width: stoneSize.width * glowScale * 0.45, height: stoneSize.height * glowScale * 0.4)
                            .blur(radius: 2.5)
                    }
                        // Keep the smaller glow centered in the stone's slot
                        .frame(width: stoneSize.width, height: stoneSize.height)
                    Spacer(minLength: 0)
                }
                .padding(.horizontal, inset + 3)
                .frame(width: width, height: height)
                .mask(RoundedRectangle(cornerRadius: 4).frame(width: width - 12, height: height - 10))
                .opacity(configuration.isOn ? 1 : 0)

                // Inner stone slides between the left and right edges of the trough
                HStack {
                    if configuration.isOn { Spacer(minLength: 0) }
                    Image("stone_inside")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: height - inset * 2 - 2)
                    if !configuration.isOn { Spacer(minLength: 0) }
                }
                .padding(.horizontal, inset + 3)
                .frame(width: width, height: height)
            }
            .animation(.spring(response: 0.7, dampingFraction: 0.88), value: configuration.isOn)
            .contentShape(Rectangle())
            .onTapGesture { configuration.isOn.toggle() }
            .accessibilityElement()
            .accessibilityAddTraits(.isButton)
            .accessibilityValue(configuration.isOn ? "On" : "Off")
        }
    }
}

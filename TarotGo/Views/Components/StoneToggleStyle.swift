import SwiftUI

/// A toggle style where an inner stone slides horizontally inside an outer stone frame.
struct StoneToggleStyle: ToggleStyle {
    private let width: CGFloat = 84
    private let height: CGFloat = 31
    private let inset: CGFloat = 5

    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            ZStack {
                Image("stone_outside")
                    .resizable()
                    .frame(width: width, height: height)

                // Inner stone slides between the left and right edges of the trough
                HStack {
                    if configuration.isOn { Spacer(minLength: 0) }
                    Image("stone_inside")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: height - inset * 2 - 2)
                        .brightness(configuration.isOn ? 0.1 : -0.25)
                        .shadow(color: AppTheme.gold.opacity(configuration.isOn ? 0.6 : 0), radius: 4)
                    if !configuration.isOn { Spacer(minLength: 0) }
                }
                .padding(.horizontal, inset + 3)
                .frame(width: width, height: height)
            }
            .animation(.spring(response: 0.3, dampingFraction: 0.75), value: configuration.isOn)
            .contentShape(Rectangle())
            .onTapGesture { configuration.isOn.toggle() }
            .accessibilityElement()
            .accessibilityAddTraits(.isButton)
            .accessibilityValue(configuration.isOn ? "On" : "Off")
        }
    }
}

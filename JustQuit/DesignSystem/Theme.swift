import SwiftUI

// MARK: - JustQuit Theme

enum JQTheme {

    // MARK: Semantic Aliases (for quick access)

    static let background = JQColors.backgroundPrimary
    static let cardBackground = JQColors.backgroundCard
    static let accent = JQColors.accentElectric
    static let success = JQColors.accentGreen
    static let warning = JQColors.accentGold
    static let danger = JQColors.accentUrgent

    // MARK: Tab Bar

    static let tabBarBackground = JQColors.backgroundPrimary.opacity(0.95)
    static let tabBarSelected = JQColors.accentElectric
    static let tabBarUnselected = JQColors.textTertiary

    // MARK: Icon Sizes

    static let iconSmall: CGFloat = 16
    static let iconMedium: CGFloat = 20
    static let iconLarge: CGFloat = 24
    static let iconXL: CGFloat = 32

    // MARK: Hit Target

    static let minTapTarget: CGFloat = 44

    // MARK: Animation Durations

    static let animationFast: Double = 0.2
    static let animationDefault: Double = 0.35
    static let animationSlow: Double = 0.5
    static let animationBreathing: Double = 2.5
}

// MARK: - Glass Background Modifier

struct GlassBackground: ViewModifier {
    var cornerRadius: CGFloat = JQRadius.card

    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(JQColors.backgroundCard)
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .fill(JQColors.cardGradient)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .stroke(JQColors.border, lineWidth: 1)
                    )
            )
    }
}

extension View {
    func glassBackground(cornerRadius: CGFloat = JQRadius.card) -> some View {
        modifier(GlassBackground(cornerRadius: cornerRadius))
    }
}

// MARK: - Full-Screen Dark Background Modifier

struct DarkBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(JQColors.backgroundPrimary.ignoresSafeArea())
    }
}

extension View {
    func darkBackground() -> some View {
        modifier(DarkBackground())
    }
}

// MARK: - Atmospheric Starfield Background

struct StarfieldBackground: View {
    let starCount: Int

    init(starCount: Int = 60) {
        self.starCount = starCount
    }

    var body: some View {
        GeometryReader { geo in
            ZStack {
                JQColors.backgroundPrimary

                ForEach(0..<starCount, id: \.self) { index in
                    let seed = Double(index)
                    Circle()
                        .fill(Color.white.opacity(stableRandom(seed: seed, min: 0.05, max: 0.25)))
                        .frame(
                            width: stableRandom(seed: seed + 100, min: 1, max: 3),
                            height: stableRandom(seed: seed + 100, min: 1, max: 3)
                        )
                        .position(
                            x: stableRandom(seed: seed + 200, min: 0, max: geo.size.width),
                            y: stableRandom(seed: seed + 300, min: 0, max: geo.size.height)
                        )
                }
            }
        }
        .ignoresSafeArea()
    }

    private func stableRandom(seed: Double, min: Double, max: Double) -> Double {
        let hash = sin(seed * 12.9898 + seed * 78.233) * 43758.5453
        let normalized = hash - floor(hash)
        return min + normalized * (max - min)
    }
}

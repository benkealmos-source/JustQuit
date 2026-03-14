import SwiftUI

// MARK: - JustQuit Color System

enum JQColors {

    // MARK: Backgrounds

    static let backgroundPrimary = Color(red: 0.06, green: 0.07, blue: 0.13)
    static let backgroundSecondary = Color(red: 0.08, green: 0.09, blue: 0.16)
    static let backgroundCard = Color(red: 0.10, green: 0.11, blue: 0.20).opacity(0.85)
    static let backgroundCardSolid = Color(red: 0.10, green: 0.11, blue: 0.20)
    static let backgroundElevated = Color(red: 0.12, green: 0.13, blue: 0.24)
    static let backgroundSheet = Color(red: 0.08, green: 0.09, blue: 0.17)

    // MARK: Accent

    static let accentElectric = Color(red: 0.20, green: 0.50, blue: 1.0)
    static let accentCyan = Color(red: 0.25, green: 0.75, blue: 0.95)
    static let accentGold = Color(red: 1.0, green: 0.78, blue: 0.28)
    static let accentGreen = Color(red: 0.30, green: 0.85, blue: 0.55)
    static let accentUrgent = Color(red: 1.0, green: 0.30, blue: 0.35)

    // MARK: Text

    static let textPrimary = Color.white
    static let textSecondary = Color.white.opacity(0.65)
    static let textTertiary = Color.white.opacity(0.40)
    static let textOnAccent = Color.white

    // MARK: Borders & Separators

    static let border = Color.white.opacity(0.08)
    static let separator = Color.white.opacity(0.06)

    // MARK: Glow Colors

    static let glowBlue = Color(red: 0.20, green: 0.50, blue: 1.0)
    static let glowCyan = Color(red: 0.25, green: 0.75, blue: 0.95)
    static let glowGold = Color(red: 1.0, green: 0.85, blue: 0.40)

    // MARK: Gradient Presets

    static let cardGradient = LinearGradient(
        colors: [
            Color.white.opacity(0.08),
            Color.white.opacity(0.02)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let accentGradient = LinearGradient(
        colors: [accentElectric, accentCyan],
        startPoint: .leading,
        endPoint: .trailing
    )

    static let backgroundGradient = LinearGradient(
        colors: [backgroundPrimary, backgroundSecondary],
        startPoint: .top,
        endPoint: .bottom
    )

    static let goldGradient = LinearGradient(
        colors: [accentGold, Color(red: 1.0, green: 0.60, blue: 0.20)],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}

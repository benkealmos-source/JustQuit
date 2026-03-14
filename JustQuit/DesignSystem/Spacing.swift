import SwiftUI

// MARK: - JustQuit Spacing & Layout System

enum JQSpacing {

    // MARK: Core Spacing Scale

    static let xxxs: CGFloat = 2
    static let xxs: CGFloat = 4
    static let xs: CGFloat = 8
    static let sm: CGFloat = 12
    static let md: CGFloat = 16
    static let lg: CGFloat = 24
    static let xl: CGFloat = 32
    static let xxl: CGFloat = 48
    static let xxxl: CGFloat = 64

    // MARK: Screen Padding

    static let screenHorizontal: CGFloat = 20
    static let screenVertical: CGFloat = 16

    // MARK: Card

    static let cardPadding: CGFloat = 16
    static let cardPaddingLarge: CGFloat = 20
    static let cardSpacing: CGFloat = 12
}

// MARK: - Corner Radii

enum JQRadius {
    static let xs: CGFloat = 6
    static let sm: CGFloat = 10
    static let md: CGFloat = 14
    static let lg: CGFloat = 18
    static let xl: CGFloat = 24
    static let card: CGFloat = 20
    static let button: CGFloat = 14
    static let chip: CGFloat = 20
    static let sheet: CGFloat = 28
}

// MARK: - Shadows & Glow

enum JQShadow {

    static func soft(color: Color = .black.opacity(0.25), radius: CGFloat = 12) -> some View {
        EmptyView()
            .shadow(color: color, radius: radius, x: 0, y: 4)
    }

    static let softRadius: CGFloat = 12
    static let softY: CGFloat = 4

    static let glowSubtleRadius: CGFloat = 8
    static let glowMediumRadius: CGFloat = 16
    static let glowStrongRadius: CGFloat = 28
}

// MARK: - View Modifier for standard glow

struct GlowModifier: ViewModifier {
    let color: Color
    let intensity: GlowIntensity

    enum GlowIntensity {
        case subtle, medium, strong

        var radius: CGFloat {
            switch self {
            case .subtle: return JQShadow.glowSubtleRadius
            case .medium: return JQShadow.glowMediumRadius
            case .strong: return JQShadow.glowStrongRadius
            }
        }
    }

    func body(content: Content) -> some View {
        content
            .shadow(color: color.opacity(0.4), radius: intensity.radius)
            .shadow(color: color.opacity(0.2), radius: intensity.radius * 1.5)
    }
}

extension View {
    func jqGlow(_ color: Color, intensity: GlowModifier.GlowIntensity = .medium) -> some View {
        modifier(GlowModifier(color: color, intensity: intensity))
    }
}

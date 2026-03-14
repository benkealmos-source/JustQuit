import SwiftUI

// MARK: - Mascot Streak Centerpiece

struct MascotStreakView: View {
    let streakDays: Int
    let longestStreak: Int

    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var breatheScale: CGFloat = 1.0
    @State private var auraRotation: Double = 0

    private var tier: StreakTier {
        StreakTier(days: streakDays)
    }

    var body: some View {
        ZStack {
            auraLayer
            orbBody
            streakLabel
        }
        .frame(width: 220, height: 220)
        .onAppear { startAnimations() }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Current streak: \(streakDays) days. Longest streak: \(longestStreak) days.")
    }

    // MARK: - Aura (outer glow rings)

    private var auraLayer: some View {
        ZStack {
            // Outer diffuse aura
            Circle()
                .fill(
                    RadialGradient(
                        colors: [tier.glowColor.opacity(0.15), .clear],
                        center: .center,
                        startRadius: 60,
                        endRadius: 130
                    )
                )
                .frame(width: 260, height: 260)
                .scaleEffect(breatheScale * 1.05)

            // Mid aura ring
            Circle()
                .stroke(tier.glowColor.opacity(0.12), lineWidth: 2)
                .frame(width: 190, height: 190)
                .scaleEffect(breatheScale)

            // Inner aura ring
            Circle()
                .stroke(
                    AngularGradient(
                        colors: [
                            tier.glowColor.opacity(0.25),
                            tier.secondaryColor.opacity(0.1),
                            tier.glowColor.opacity(0.25)
                        ],
                        center: .center
                    ),
                    lineWidth: 1.5
                )
                .frame(width: 170, height: 170)
                .rotationEffect(.degrees(auraRotation))
        }
    }

    // MARK: - Orb body (the mascot)

    private var orbBody: some View {
        ZStack {
            // Core sphere gradient
            Circle()
                .fill(
                    RadialGradient(
                        colors: [
                            tier.coreHighlight,
                            tier.coreColor,
                            tier.coreColor.opacity(0.85)
                        ],
                        center: .init(x: 0.4, y: 0.35),
                        startRadius: 5,
                        endRadius: 65
                    )
                )
                .frame(width: 120, height: 120)

            // Glass highlight
            Ellipse()
                .fill(
                    LinearGradient(
                        colors: [Color.white.opacity(0.30), Color.white.opacity(0.0)],
                        startPoint: .top,
                        endPoint: .center
                    )
                )
                .frame(width: 70, height: 40)
                .offset(y: -25)

            // Inner glow ring
            Circle()
                .stroke(tier.glowColor.opacity(0.3), lineWidth: 2)
                .frame(width: 124, height: 124)
                .blur(radius: 2)
        }
        .scaleEffect(breatheScale)
        .shadow(color: tier.glowColor.opacity(tier.glowIntensity), radius: 20)
        .shadow(color: tier.glowColor.opacity(tier.glowIntensity * 0.5), radius: 40)
    }

    // MARK: - Streak number

    private var streakLabel: some View {
        VStack(spacing: 2) {
            Text("\(streakDays)")
                .font(JQTypography.numberDisplay)
                .foregroundStyle(JQColors.textPrimary)
                .shadow(color: tier.glowColor.opacity(0.5), radius: 8)

            Text(streakDays == 1 ? "day" : "days")
                .font(JQTypography.captionMedium)
                .foregroundStyle(JQColors.textSecondary)
        }
        .offset(y: 2)
    }

    // MARK: - Animations

    private func startAnimations() {
        guard !reduceMotion else { return }

        withAnimation(
            .easeInOut(duration: JQTheme.animationBreathing)
            .repeatForever(autoreverses: true)
        ) {
            breatheScale = 1.03
        }

        withAnimation(
            .linear(duration: 30)
            .repeatForever(autoreverses: false)
        ) {
            auraRotation = 360
        }
    }
}

// MARK: - Streak Tier System

enum StreakTier {
    case nascent      // 0
    case awakening    // 1-3
    case building     // 4-14
    case ascending    // 15-29
    case transcendent // 30+

    init(days: Int) {
        switch days {
        case 0: self = .nascent
        case 1...3: self = .awakening
        case 4...14: self = .building
        case 15...29: self = .ascending
        default: self = .transcendent
        }
    }

    var coreColor: Color {
        switch self {
        case .nascent: return Color(red: 0.15, green: 0.20, blue: 0.40)
        case .awakening: return Color(red: 0.15, green: 0.30, blue: 0.60)
        case .building: return Color(red: 0.12, green: 0.45, blue: 0.75)
        case .ascending: return Color(red: 0.20, green: 0.55, blue: 0.80)
        case .transcendent: return Color(red: 0.55, green: 0.50, blue: 0.25)
        }
    }

    var coreHighlight: Color {
        switch self {
        case .nascent: return Color(red: 0.25, green: 0.30, blue: 0.55)
        case .awakening: return Color(red: 0.30, green: 0.50, blue: 0.80)
        case .building: return Color(red: 0.30, green: 0.65, blue: 0.90)
        case .ascending: return Color(red: 0.40, green: 0.75, blue: 0.95)
        case .transcendent: return Color(red: 0.90, green: 0.80, blue: 0.45)
        }
    }

    var glowColor: Color {
        switch self {
        case .nascent: return JQColors.glowBlue.opacity(0.4)
        case .awakening: return JQColors.glowBlue
        case .building: return JQColors.glowCyan
        case .ascending: return JQColors.glowCyan
        case .transcendent: return JQColors.glowGold
        }
    }

    var secondaryColor: Color {
        switch self {
        case .nascent, .awakening: return JQColors.accentElectric
        case .building: return JQColors.accentCyan
        case .ascending: return JQColors.accentGreen
        case .transcendent: return JQColors.accentGold
        }
    }

    var glowIntensity: Double {
        switch self {
        case .nascent: return 0.15
        case .awakening: return 0.25
        case .building: return 0.35
        case .ascending: return 0.45
        case .transcendent: return 0.55
        }
    }

    var tierLabel: String {
        switch self {
        case .nascent: return "Begin"
        case .awakening: return "Awakening"
        case .building: return "Building"
        case .ascending: return "Ascending"
        case .transcendent: return "Transcendent"
        }
    }
}

// MARK: - Preview

#Preview("Low Streak") {
    ZStack {
        StarfieldBackground()
        MascotStreakView(streakDays: 2, longestStreak: 14)
    }
}

#Preview("Mid Streak") {
    ZStack {
        StarfieldBackground()
        MascotStreakView(streakDays: 10, longestStreak: 14)
    }
}

#Preview("High Streak") {
    ZStack {
        StarfieldBackground()
        MascotStreakView(streakDays: 35, longestStreak: 35)
    }
}

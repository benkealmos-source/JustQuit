import SwiftUI

struct RewireProgressCard: View {
    let progress: Double
    let label: String
    let streakDays: Int

    var body: some View {
        GlassCard {
            VStack(alignment: .leading, spacing: JQSpacing.sm) {
                HStack {
                    Image(systemName: "brain.head.profile")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(JQColors.accentGreen)

                    Text("Rewiring Progress")
                        .font(JQTypography.emphasisLarge)
                        .foregroundStyle(JQColors.textPrimary)

                    Spacer()

                    Text("\(Int(progress * 100))%")
                        .font(JQTypography.numberSmall)
                        .foregroundStyle(JQColors.accentGreen)
                }

                progressBar

                Text(label)
                    .font(JQTypography.caption)
                    .foregroundStyle(JQColors.textTertiary)

                Text("Not medical advice. Based on commonly reported user experiences.")
                    .font(JQTypography.caption)
                    .foregroundStyle(JQColors.textTertiary.opacity(0.6))
                    .italic()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    private var progressBar: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 4)
                    .fill(JQColors.backgroundElevated)

                RoundedRectangle(cornerRadius: 4)
                    .fill(
                        LinearGradient(
                            colors: [JQColors.accentGreen, JQColors.accentCyan],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: geo.size.width * min(progress, 1.0))
                    .animation(.easeInOut(duration: 0.6), value: progress)
            }
        }
        .frame(height: 8)
        .accessibilityValue("\(Int(progress * 100)) percent")
    }
}

// MARK: - Stats Row

struct StreakStatsRow: View {
    let longestStreak: Int
    let relapseCount: Int

    var body: some View {
        HStack(spacing: JQSpacing.sm) {
            StatCard(
                icon: "trophy.fill",
                value: "\(longestStreak)",
                label: "Longest",
                color: JQColors.accentGold
            )

            StatCard(
                icon: "arrow.counterclockwise",
                value: "\(relapseCount)",
                label: "Relapses",
                color: JQColors.accentUrgent
            )
        }
    }
}

struct StatCard: View {
    let icon: String
    let value: String
    let label: String
    let color: Color

    var body: some View {
        GlassCard(cornerRadius: JQRadius.md) {
            HStack(spacing: JQSpacing.sm) {
                Image(systemName: icon)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(color)

                VStack(alignment: .leading, spacing: 2) {
                    Text(value)
                        .font(JQTypography.numberSmall)
                        .foregroundStyle(JQColors.textPrimary)
                    Text(label)
                        .font(JQTypography.caption)
                        .foregroundStyle(JQColors.textTertiary)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

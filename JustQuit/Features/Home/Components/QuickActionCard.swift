import SwiftUI

struct QuickActionCard: View {
    let icon: String
    let title: String
    let color: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: JQSpacing.xs) {
                Image(systemName: icon)
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundStyle(color)
                    .frame(width: 44, height: 44)
                    .background(
                        Circle()
                            .fill(color.opacity(0.12))
                    )

                Text(title)
                    .font(JQTypography.captionMedium)
                    .foregroundStyle(JQColors.textSecondary)
                    .lineLimit(1)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, JQSpacing.sm)
            .glassBackground(cornerRadius: JQRadius.md)
        }
        .accessibilityLabel(title)
    }
}

struct QuickActionsRow: View {
    let onCheckIn: () -> Void
    let onPanic: () -> Void
    let onBreathing: () -> Void

    var body: some View {
        HStack(spacing: JQSpacing.sm) {
            QuickActionCard(
                icon: "checkmark.circle",
                title: "Check In",
                color: JQColors.accentGreen,
                action: onCheckIn
            )

            QuickActionCard(
                icon: "exclamationmark.shield.fill",
                title: "SOS",
                color: JQColors.accentUrgent,
                action: onPanic
            )

            QuickActionCard(
                icon: "wind",
                title: "Breathe",
                color: JQColors.accentCyan,
                action: onBreathing
            )
        }
    }
}

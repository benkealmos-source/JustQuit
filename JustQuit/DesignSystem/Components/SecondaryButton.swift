import SwiftUI

struct SecondaryButton: View {
    let title: String
    let icon: String?
    let action: () -> Void

    init(
        _ title: String,
        icon: String? = nil,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.icon = icon
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            HStack(spacing: JQSpacing.xs) {
                if let icon {
                    Image(systemName: icon)
                        .font(.system(size: JQTheme.iconMedium, weight: .medium))
                }
                Text(title)
                    .font(JQTypography.buttonSecondary)
            }
            .foregroundStyle(JQColors.accentElectric)
            .frame(maxWidth: .infinity)
            .frame(height: 48)
            .background(
                RoundedRectangle(cornerRadius: JQRadius.button)
                    .stroke(JQColors.accentElectric.opacity(0.4), lineWidth: 1.5)
                    .background(
                        RoundedRectangle(cornerRadius: JQRadius.button)
                            .fill(JQColors.accentElectric.opacity(0.08))
                    )
            )
        }
        .accessibilityLabel(title)
    }
}

// MARK: - Text-only link-style button

struct TextLinkButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(JQTypography.captionMedium)
                .foregroundStyle(JQColors.textSecondary)
                .underline()
        }
        .accessibilityLabel(title)
    }
}

#Preview {
    ZStack {
        JQColors.backgroundPrimary.ignoresSafeArea()
        VStack(spacing: JQSpacing.md) {
            SecondaryButton("Restore Purchases", icon: "arrow.clockwise") {}
            TextLinkButton(title: "Terms of Use") {}
        }
        .padding()
    }
}

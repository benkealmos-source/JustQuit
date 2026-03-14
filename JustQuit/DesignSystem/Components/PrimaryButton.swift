import SwiftUI

struct PrimaryButton: View {
    let title: String
    let icon: String?
    let isLoading: Bool
    let action: () -> Void

    init(
        _ title: String,
        icon: String? = nil,
        isLoading: Bool = false,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.icon = icon
        self.isLoading = isLoading
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            HStack(spacing: JQSpacing.xs) {
                if isLoading {
                    ProgressView()
                        .tint(.white)
                        .scaleEffect(0.85)
                } else {
                    if let icon {
                        Image(systemName: icon)
                            .font(.system(size: JQTheme.iconMedium, weight: .semibold))
                    }
                    Text(title)
                        .font(JQTypography.buttonPrimary)
                }
            }
            .foregroundStyle(JQColors.textOnAccent)
            .frame(maxWidth: .infinity)
            .frame(height: 52)
            .background(
                RoundedRectangle(cornerRadius: JQRadius.button)
                    .fill(JQColors.accentGradient)
            )
            .shadow(color: JQColors.accentElectric.opacity(0.3), radius: 12, y: 4)
        }
        .disabled(isLoading)
        .accessibilityLabel(title)
    }
}

#Preview {
    ZStack {
        JQColors.backgroundPrimary.ignoresSafeArea()
        VStack(spacing: JQSpacing.md) {
            PrimaryButton("Continue", icon: "arrow.right") {}
            PrimaryButton("Loading...", isLoading: true) {}
        }
        .padding()
    }
}

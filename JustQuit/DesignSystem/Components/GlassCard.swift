import SwiftUI

struct GlassCard<Content: View>: View {
    let cornerRadius: CGFloat
    let padding: CGFloat
    @ViewBuilder let content: () -> Content

    init(
        cornerRadius: CGFloat = JQRadius.card,
        padding: CGFloat = JQSpacing.cardPadding,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.cornerRadius = cornerRadius
        self.padding = padding
        self.content = content
    }

    var body: some View {
        content()
            .padding(padding)
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
                    .shadow(color: .black.opacity(0.2), radius: JQShadow.softRadius, y: JQShadow.softY)
            )
    }
}

// MARK: - Compact variant for smaller inline cards

struct GlassCardCompact<Content: View>: View {
    @ViewBuilder let content: () -> Content

    var body: some View {
        GlassCard(cornerRadius: JQRadius.md, padding: JQSpacing.sm, content: content)
    }
}

#Preview {
    ZStack {
        JQColors.backgroundPrimary.ignoresSafeArea()

        GlassCard {
            VStack(alignment: .leading, spacing: JQSpacing.sm) {
                Text("Daily Quote")
                    .font(JQTypography.emphasisLarge)
                    .foregroundStyle(JQColors.textPrimary)
                Text("The only way out is through.")
                    .font(JQTypography.body)
                    .foregroundStyle(JQColors.textSecondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
    }
}

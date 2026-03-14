import SwiftUI

struct DailyQuoteCard: View {
    let quote: Quote

    var body: some View {
        GlassCard {
            VStack(alignment: .leading, spacing: JQSpacing.sm) {
                HStack {
                    Image(systemName: "quote.opening")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(JQColors.accentGold)

                    Text("Daily Wisdom")
                        .font(JQTypography.captionMedium)
                        .foregroundStyle(JQColors.accentGold)

                    Spacer()
                }

                Text(quote.text)
                    .font(JQTypography.bodyLarge)
                    .foregroundStyle(JQColors.textPrimary)
                    .lineSpacing(4)

                if let author = quote.author {
                    Text("— \(author)")
                        .font(JQTypography.caption)
                        .foregroundStyle(JQColors.textTertiary)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

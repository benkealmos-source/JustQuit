import SwiftUI

struct StoriesQuotesView: View {
    @State private var selectedTab: ContentTab = .stories
    private let stories = MockData.stories
    private let quotes = MockData.quotes

    var body: some View {
        NavigationStack {
            ZStack {
                JQColors.backgroundPrimary.ignoresSafeArea()

                VStack(spacing: JQSpacing.md) {
                    segmentPicker
                    contentList
                }
            }
            .navigationTitle("Inspiration")
            .navigationBarTitleDisplayMode(.large)
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
    }

    // MARK: - Segment

    private var segmentPicker: some View {
        HStack(spacing: JQSpacing.xs) {
            ForEach(ContentTab.allCases) { tab in
                let isSelected = selectedTab == tab
                Button {
                    withAnimation { selectedTab = tab }
                } label: {
                    Text(tab.title)
                        .font(JQTypography.buttonSmall)
                        .foregroundStyle(isSelected ? JQColors.textOnAccent : JQColors.textSecondary)
                        .padding(.horizontal, JQSpacing.md)
                        .padding(.vertical, JQSpacing.xs)
                        .background(
                            Capsule()
                                .fill(isSelected ? JQColors.accentElectric : JQColors.backgroundElevated)
                        )
                }
            }
        }
        .screenPadding()
    }

    // MARK: - Content

    @ViewBuilder
    private var contentList: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: JQSpacing.md) {
                switch selectedTab {
                case .stories:
                    ForEach(stories) { story in
                        storyCard(story)
                    }
                case .quotes:
                    ForEach(quotes) { quote in
                        quoteCard(quote)
                    }
                }
            }
            .screenPadding()
            .padding(.bottom, JQSpacing.xxl)
        }
    }

    private func storyCard(_ story: Story) -> some View {
        GlassCard {
            VStack(alignment: .leading, spacing: JQSpacing.sm) {
                HStack {
                    Text(story.sourceLabel.rawValue)
                        .font(JQTypography.captionMedium)
                        .foregroundStyle(JQColors.accentCyan)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 3)
                        .background(
                            Capsule().fill(JQColors.accentCyan.opacity(0.12))
                        )
                    Spacer()
                    Text(story.category.rawValue.capitalized)
                        .font(JQTypography.caption)
                        .foregroundStyle(JQColors.textTertiary)
                }

                Text(story.title)
                    .font(JQTypography.emphasisLarge)
                    .foregroundStyle(JQColors.textPrimary)

                Text(story.body)
                    .font(JQTypography.body)
                    .foregroundStyle(JQColors.textSecondary)
                    .lineSpacing(4)
                    .lineLimit(4)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    private func quoteCard(_ quote: Quote) -> some View {
        GlassCard {
            VStack(alignment: .leading, spacing: JQSpacing.sm) {
                Image(systemName: "quote.opening")
                    .font(.system(size: 14))
                    .foregroundStyle(JQColors.accentGold)

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

private enum ContentTab: String, CaseIterable, Identifiable {
    case stories
    case quotes

    var id: String { rawValue }

    var title: String {
        switch self {
        case .stories: return "Stories"
        case .quotes: return "Quotes"
        }
    }
}

#Preview {
    StoriesQuotesView()
        .preferredColorScheme(.dark)
}

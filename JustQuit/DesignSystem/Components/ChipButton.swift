import SwiftUI

struct ChipButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(JQTypography.chip)
                .foregroundStyle(isSelected ? JQColors.textOnAccent : JQColors.textSecondary)
                .padding(.horizontal, JQSpacing.md)
                .padding(.vertical, JQSpacing.sm)
                .background(
                    Capsule()
                        .fill(isSelected ? JQColors.accentElectric : JQColors.backgroundElevated)
                        .overlay(
                            Capsule()
                                .stroke(
                                    isSelected ? Color.clear : JQColors.border,
                                    lineWidth: 1
                                )
                        )
                )
                .animation(.easeInOut(duration: JQTheme.animationFast), value: isSelected)
        }
        .accessibilityAddTraits(isSelected ? .isSelected : [])
        .accessibilityLabel(title)
    }
}

// MARK: - Multi-select chip group

struct ChipGroup: View {
    let options: [String]
    @Binding var selected: Set<String>
    let allowMultiple: Bool

    init(options: [String], selected: Binding<Set<String>>, allowMultiple: Bool = true) {
        self.options = options
        self._selected = selected
        self.allowMultiple = allowMultiple
    }

    var body: some View {
        FlowLayout(spacing: JQSpacing.xs) {
            ForEach(options, id: \.self) { option in
                ChipButton(title: option, isSelected: selected.contains(option)) {
                    if allowMultiple {
                        if selected.contains(option) {
                            selected.remove(option)
                        } else {
                            selected.insert(option)
                        }
                    } else {
                        selected = [option]
                    }
                }
            }
        }
    }
}

// MARK: - Flow Layout for wrapping chips

struct FlowLayout: Layout {
    var spacing: CGFloat

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let result = arrange(proposal: proposal, subviews: subviews)
        return result.size
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let result = arrange(proposal: proposal, subviews: subviews)
        for (index, position) in result.positions.enumerated() {
            subviews[index].place(
                at: CGPoint(x: bounds.minX + position.x, y: bounds.minY + position.y),
                proposal: .unspecified
            )
        }
    }

    private func arrange(proposal: ProposedViewSize, subviews: Subviews) -> ArrangementResult {
        let maxWidth = proposal.width ?? .infinity
        var positions: [CGPoint] = []
        var currentX: CGFloat = 0
        var currentY: CGFloat = 0
        var lineHeight: CGFloat = 0

        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            if currentX + size.width > maxWidth, currentX > 0 {
                currentX = 0
                currentY += lineHeight + spacing
                lineHeight = 0
            }
            positions.append(CGPoint(x: currentX, y: currentY))
            lineHeight = max(lineHeight, size.height)
            currentX += size.width + spacing
        }

        let totalHeight = currentY + lineHeight
        return ArrangementResult(
            size: CGSize(width: maxWidth, height: totalHeight),
            positions: positions
        )
    }

    private struct ArrangementResult {
        let size: CGSize
        let positions: [CGPoint]
    }
}

#Preview {
    ZStack {
        JQColors.backgroundPrimary.ignoresSafeArea()

        ChipGroup(
            options: ["Stress", "Boredom", "Loneliness", "Late Night", "Social Media", "Anxiety"],
            selected: .constant(Set(["Stress", "Late Night"]))
        )
        .padding()
    }
}

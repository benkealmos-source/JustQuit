import SwiftUI

struct BoredPanicView: View {
    @State private var showBreathing = false
    private let content = MockData.boredomContent

    var body: some View {
        NavigationStack {
            ZStack {
                JQColors.backgroundPrimary.ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: JQSpacing.lg) {
                        panicSection
                        quickActions
                        contentGrid
                    }
                    .screenPadding()
                    .padding(.vertical, JQSpacing.md)
                }
            }
            .navigationTitle("SOS")
            .navigationBarTitleDisplayMode(.large)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .sheet(isPresented: $showBreathing) {
                breathingSheet
            }
        }
    }

    // MARK: - Panic Button

    private var panicSection: some View {
        VStack(spacing: JQSpacing.md) {
            Text("Feeling an urge? You've got this.")
                .font(JQTypography.body)
                .foregroundStyle(JQColors.textSecondary)
                .multilineTextAlignment(.center)

            Button {
                showBreathing = true
            } label: {
                VStack(spacing: JQSpacing.xs) {
                    Image(systemName: "exclamationmark.shield.fill")
                        .font(.system(size: 40, weight: .semibold))
                    Text("PANIC BUTTON")
                        .font(JQTypography.buttonPrimary)
                }
                .foregroundStyle(.white)
                .frame(width: 160, height: 160)
                .background(
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [JQColors.accentUrgent, JQColors.accentUrgent.opacity(0.7)],
                                center: .center,
                                startRadius: 10,
                                endRadius: 80
                            )
                        )
                        .shadow(color: JQColors.accentUrgent.opacity(0.4), radius: 20)
                )
            }
            .accessibilityLabel("Panic button. Opens breathing exercise.")
        }
    }

    // MARK: - Quick Actions

    private var quickActions: some View {
        VStack(alignment: .leading, spacing: JQSpacing.sm) {
            Text("Quick Actions")
                .font(JQTypography.emphasisLarge)
                .foregroundStyle(JQColors.textPrimary)

            HStack(spacing: JQSpacing.sm) {
                quickTile("wind", "Breathe", JQColors.accentCyan) { showBreathing = true }
                quickTile("figure.walk", "Walk", JQColors.accentGreen) {}
                quickTile("dumbbell", "Exercise", JQColors.accentGold) {}
                quickTile("pencil.and.scribble", "Journal", JQColors.accentElectric) {}
            }
        }
    }

    private func quickTile(_ icon: String, _ label: String, _ color: Color, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            VStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(color)
                Text(label)
                    .font(JQTypography.captionMedium)
                    .foregroundStyle(JQColors.textSecondary)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, JQSpacing.sm)
            .glassBackground(cornerRadius: JQRadius.md)
        }
    }

    // MARK: - Content Grid

    private var contentGrid: some View {
        VStack(alignment: .leading, spacing: JQSpacing.sm) {
            Text("Distract & Redirect")
                .font(JQTypography.emphasisLarge)
                .foregroundStyle(JQColors.textPrimary)

            ForEach(content) { item in
                contentRow(item)
            }
        }
    }

    private func contentRow(_ item: BoredomContent) -> some View {
        GlassCard(cornerRadius: JQRadius.md, padding: JQSpacing.sm) {
            HStack(spacing: JQSpacing.sm) {
                Image(systemName: item.iconName ?? "circle")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(colorForType(item.type))
                    .frame(width: 36, height: 36)
                    .background(
                        Circle().fill(colorForType(item.type).opacity(0.12))
                    )

                VStack(alignment: .leading, spacing: 2) {
                    Text(item.title)
                        .font(JQTypography.bodyMedium)
                        .foregroundStyle(JQColors.textPrimary)
                    if let subtitle = item.subtitle {
                        Text(subtitle)
                            .font(JQTypography.caption)
                            .foregroundStyle(JQColors.textTertiary)
                            .lineLimit(1)
                    }
                }

                Spacer()

                if item.url != nil {
                    Image(systemName: "arrow.up.right")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(JQColors.textTertiary)
                }
            }
        }
    }

    private func colorForType(_ type: BoredomContent.ContentType) -> Color {
        switch type {
        case .breathing, .meditation: return JQColors.accentCyan
        case .walk, .exercise: return JQColors.accentGreen
        case .youtubeLink: return JQColors.accentUrgent
        case .book: return JQColors.accentGold
        case .journalPrompt: return JQColors.accentElectric
        }
    }

    // MARK: - Breathing Sheet

    private var breathingSheet: some View {
        BreathingExerciseView(onDismiss: { showBreathing = false })
    }
}

// MARK: - Breathing Exercise

struct BreathingExerciseView: View {
    let onDismiss: () -> Void
    @State private var phase: BreathPhase = .inhale
    @State private var circleScale: CGFloat = 0.6
    @State private var cycleCount = 0
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        ZStack {
            JQColors.backgroundSheet.ignoresSafeArea()

            VStack(spacing: JQSpacing.xl) {
                Spacer()

                ZStack {
                    Circle()
                        .fill(
                            RadialGradient(
                                colors: [JQColors.accentCyan.opacity(0.3), .clear],
                                center: .center,
                                startRadius: 20,
                                endRadius: 100
                            )
                        )
                        .frame(width: 200, height: 200)
                        .scaleEffect(circleScale)

                    Circle()
                        .fill(JQColors.accentCyan.opacity(0.15))
                        .frame(width: 140, height: 140)
                        .scaleEffect(circleScale)
                }

                Text(phase.instruction)
                    .font(JQTypography.titleMedium)
                    .foregroundStyle(JQColors.textPrimary)
                    .animation(.easeInOut, value: phase)

                Text("\(phase.duration)s")
                    .font(JQTypography.numberMedium)
                    .foregroundStyle(JQColors.accentCyan)

                Text("Cycle \(cycleCount + 1) / 4")
                    .font(JQTypography.caption)
                    .foregroundStyle(JQColors.textTertiary)

                Spacer()

                SecondaryButton("Done") {
                    onDismiss()
                }
                .screenPadding()
                .padding(.bottom, JQSpacing.lg)
            }
        }
        .onAppear { startBreathingCycle() }
        .presentationDetents([.large])
        .presentationDragIndicator(.visible)
    }

    private func startBreathingCycle() {
        guard !reduceMotion else { return }
        animatePhase(.inhale)
    }

    private func animatePhase(_ newPhase: BreathPhase) {
        phase = newPhase
        let targetScale: CGFloat = newPhase == .inhale ? 1.0 : (newPhase == .hold ? 1.0 : 0.6)

        withAnimation(.easeInOut(duration: Double(newPhase.duration))) {
            circleScale = targetScale
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + Double(newPhase.duration)) {
            switch newPhase {
            case .inhale: animatePhase(.hold)
            case .hold: animatePhase(.exhale)
            case .exhale:
                cycleCount += 1
                if cycleCount < 4 {
                    animatePhase(.inhale)
                }
            }
        }
    }
}

private enum BreathPhase {
    case inhale, hold, exhale

    var instruction: String {
        switch self {
        case .inhale: return "Breathe In"
        case .hold: return "Hold"
        case .exhale: return "Breathe Out"
        }
    }

    var duration: Int {
        4
    }
}

#Preview {
    BoredPanicView()
        .preferredColorScheme(.dark)
}

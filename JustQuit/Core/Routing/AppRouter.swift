import SwiftUI

// MARK: - Root Router View

struct AppRouter: View {
    @EnvironmentObject private var appState: AppState

    var body: some View {
        Group {
            switch appState.currentRoute {
            case .launch:
                LaunchView()
                    .transition(.opacity)

            case .onboarding:
                OnboardingQuizView()
                    .transition(.asymmetric(
                        insertion: .move(edge: .trailing),
                        removal: .move(edge: .leading)
                    ))

            case .result:
                ResultView()
                    .transition(.move(edge: .trailing))

            case .paywall:
                PaywallView()
                    .transition(.move(edge: .trailing))

            case .auth:
                AuthView()
                    .transition(.move(edge: .trailing))

            case .main:
                MainTabView()
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: JQTheme.animationDefault), value: appState.currentRoute)
    }
}

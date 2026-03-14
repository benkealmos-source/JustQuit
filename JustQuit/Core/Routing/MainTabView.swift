import SwiftUI

struct MainTabView: View {
    @EnvironmentObject private var appState: AppState

    var body: some View {
        TabView(selection: $appState.currentTab) {
            HomeView()
                .tabItem {
                    Label(AppTab.home.title, systemImage: AppTab.home.icon)
                }
                .tag(AppTab.home)

            StoriesQuotesView()
                .tabItem {
                    Label(AppTab.stories.title, systemImage: AppTab.stories.icon)
                }
                .tag(AppTab.stories)

            FutureSelfView()
                .tabItem {
                    Label(AppTab.futureSelf.title, systemImage: AppTab.futureSelf.icon)
                }
                .tag(AppTab.futureSelf)

            StreakRemindersView()
                .tabItem {
                    Label(AppTab.streak.title, systemImage: AppTab.streak.icon)
                }
                .tag(AppTab.streak)

            BoredPanicView()
                .tabItem {
                    Label(AppTab.bored.title, systemImage: AppTab.bored.icon)
                }
                .tag(AppTab.bored)

            SettingsView()
                .tabItem {
                    Label(AppTab.settings.title, systemImage: AppTab.settings.icon)
                }
                .tag(AppTab.settings)
        }
        .tint(JQColors.accentElectric)
        .onAppear {
            configureTabBarAppearance()
        }
    }

    private func configureTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(JQColors.backgroundPrimary.opacity(0.95))
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor(JQColors.accentElectric)
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor(JQColors.accentElectric)
        ]
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor(JQColors.textTertiary)
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor(JQColors.textTertiary)
        ]
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}

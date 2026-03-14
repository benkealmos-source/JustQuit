import SwiftUI

@main
struct JustQuitApp: App {
    @StateObject private var appState = AppState()

    // TODO: Configure Firebase in init()
    // TODO: Configure RevenueCat in init()
    // TODO: Configure Crashlytics in init()

    var body: some Scene {
        WindowGroup {
            AppRouter()
                .environmentObject(appState)
                .preferredColorScheme(.dark)
        }
    }
}

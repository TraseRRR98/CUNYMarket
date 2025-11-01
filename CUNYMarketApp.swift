import SwiftUI

@main
struct CUNYMarketApp: App {
    // Global singletons for app data and theme
    @StateObject private var appState = AppState()
    @StateObject private var appTheme = AppTheme()

    var body: some Scene {
        WindowGroup {
            // Entry point: Splash screen controls flow
            SplashView()
                .environmentObject(appState)
                .environmentObject(appTheme)
                // Apply dark/light appearance dynamically
                .preferredColorScheme(appTheme.isDarkMode ? .dark : .light)
        }
    }
}

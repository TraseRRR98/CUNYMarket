import SwiftUI
import Combine

final class AppTheme: ObservableObject {
    // Stores user’s dark mode preference
    @AppStorage("isDarkMode") var isDarkMode: Bool = false {
        didSet {
            // Apply the system appearance instantly when toggled
            DispatchQueue.main.async {
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                    windowScene.windows.first?.overrideUserInterfaceStyle = self.isDarkMode ? .dark : .light
                }
            }
        }
    }
}

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        TabView {
            // 🏠 Home
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }

            // 👤 Profile
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }

            // 💬 Chats — add this section
            ChatsView()
                .tabItem {
                    Label("Chats", systemImage: "bubble.left.and.bubble.right.fill")
                }

            // 💳 Payment Info
            PaymentInfoView()
                .tabItem {
                    Label("Payments", systemImage: "creditcard.fill")
                }

            // 🤖 AI Assistant
            AIAgentView()
                .tabItem {
                    Label("AI", systemImage: "sparkles")
                }
        }
        .environmentObject(appState)
    }
}

#Preview {
    MainTabView().environmentObject(AppState())
}

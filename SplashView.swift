import SwiftUI

struct SplashView: View {
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var appTheme: AppTheme
    @State private var isActive = false
    @State private var progress: Double = 0.0

    var body: some View {
        ZStack {
            // Background color adjusts with mode
            (appTheme.isDarkMode ? Color.black : Color.white)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Spacer()

                // App logo / title
                Text("CUNYMarket")
                    .font(.system(size: 42, weight: .heavy, design: .rounded))
                    .foregroundColor(.blue)
                    .shadow(radius: 5)

                Text("Safe Exchange Students Deserve")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .padding(.bottom, 40)

                // Progress animation
                ProgressView(value: progress, total: 100)
                    .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                    .frame(width: 200)
                    .padding(.bottom, 50)

                Spacer()
            }
        }
        // When the splash appears, simulate loading
        .onAppear {
            startLoadingAnimation()
        }
        // When loading is done, navigate automatically
        .fullScreenCover(isPresented: $isActive) {
            if appState.isLoggedIn {
                MainTabView()
                    .environmentObject(appState)
                    .environmentObject(appTheme)
            } else {
                WelcomeView()
                    .environmentObject(appState)
                    .environmentObject(appTheme)
            }
        }
    }

    // MARK: - Simulated loading
    func startLoadingAnimation() {
        // Animate progress bar
        Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { timer in
            progress += 1
            if progress >= 100 {
                timer.invalidate()
                withAnimation {
                    isActive = true
                }
            }
        }
    }
}

#Preview {
    SplashView()
        .environmentObject(AppState())
        .environmentObject(AppTheme())
}

import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var appTheme: AppTheme

    var body: some View {
        NavigationView {
            ZStack {
                // Background color based on theme
                (appTheme.isDarkMode ? Color.black : Color.white)
                    .ignoresSafeArea()

                VStack(spacing: 24) {
                    Spacer()

                    // Title and slogan
                    VStack(spacing: 8) {
                        Text("CUNYMarket")
                            .font(.system(size: 40, weight: .heavy, design: .rounded))
                            .foregroundColor(.blue)

                        Text("Safe Exchange Students Deserve")
                            .font(.headline)
                            .foregroundColor(.gray)
                    }

                    Spacer()

                    // Buttons
                    VStack(spacing: 16) {
                        NavigationLink(destination: SignupView()
                            .environmentObject(appState)
                            .environmentObject(appTheme)
                        ) {
                            Text("Sign Up")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .shadow(radius: 3)
                        }

                        NavigationLink(destination: LoginView()
                            .environmentObject(appState)
                            .environmentObject(appTheme)
                        ) {
                            Text("Login")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white)
                                .foregroundColor(.blue)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.blue, lineWidth: 2)
                                )
                        }
                    }
                    .padding(.horizontal, 40)

                    Spacer()

                    // Dark mode toggle on welcome screen
                    HStack {
                        Spacer()
                        Button(action: {
                            withAnimation {
                                appTheme.isDarkMode.toggle()
                            }
                        }) {
                            Label(
                                appTheme.isDarkMode ? "Light Mode" : "Dark Mode",
                                systemImage: appTheme.isDarkMode ? "sun.max.fill" : "moon.fill"
                            )
                            .font(.footnote)
                            .foregroundColor(.gray)
                        }
                        .padding(.bottom, 20)
                        .padding(.trailing, 20)
                    }
                }
            }
        }
    }
}

#Preview {
    WelcomeView()
        .environmentObject(AppState())
        .environmentObject(AppTheme())
}

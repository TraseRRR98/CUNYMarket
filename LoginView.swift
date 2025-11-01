import SwiftUI

struct LoginView: View {
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var appTheme: AppTheme

    @State private var email = ""
    @State private var password = ""
    @State private var showPassword = false
    @State private var invalidEmail = false

    var body: some View {
        ZStack {
            (appTheme.isDarkMode ? Color.black : Color.white)
                .ignoresSafeArea()

            VStack(spacing: 22) {
                Spacer()

                Text("Welcome Back 👋")
                    .font(.largeTitle.bold())
                    .foregroundColor(.blue)

                Text("Login with your CUNY email")
                    .foregroundColor(.gray)
                    .font(.subheadline)

                VStack(spacing: 16) {
                    TextField("CUNY Email", text: $email)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)

                    if invalidEmail {
                        Text("❌ Must use your CUNY email address")
                            .font(.footnote)
                            .foregroundColor(.red)
                    }

                    HStack {
                        if showPassword {
                            TextField("Password", text: $password)
                                .autocapitalization(.none)
                        } else {
                            SecureField("Password", text: $password)
                        }

                        Button {
                            showPassword.toggle()
                        } label: {
                            Image(systemName: showPassword ? "eye.slash" : "eye")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                }

                Button(action: handleLogin) {
                    Text("Login")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.top, 10)
                .shadow(radius: 3)

                Spacer()

                // Dark mode toggle
                Button {
                    withAnimation {
                        appTheme.isDarkMode.toggle()
                    }
                } label: {
                    Label(
                        appTheme.isDarkMode ? "Light Mode" : "Dark Mode",
                        systemImage: appTheme.isDarkMode ? "sun.max.fill" : "moon.fill"
                    )
                    .font(.footnote)
                    .foregroundColor(.gray)
                }
                .padding(.bottom, 20)
            }
            .padding(.horizontal, 40)
        }
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Logic
    func handleLogin() {
        guard email.lowercased().contains("cuny.edu") else {
            invalidEmail = true
            return
        }
        appState.userEmail = email
        appState.isLoggedIn = true
    }
}

#Preview {
    LoginView()
        .environmentObject(AppState())
        .environmentObject(AppTheme())
}

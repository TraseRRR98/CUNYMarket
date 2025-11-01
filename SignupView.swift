import SwiftUI

struct SignupView: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.colorScheme) var colorScheme

    // Step control
    @State private var step = 1

    // STEP 1
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var username = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showPassword = false
    @State private var agreeToTOS = false
    @State private var showEmailError = false

    // STEP 2
    @State private var college = ""
    @State private var major = ""
    @State private var year = "Freshman"
    @State private var startDate = Date()
    @State private var gradDate = Date()
    @State private var selectedMonth = 1
    @State private var selectedDay = 1
    @State private var selectedYear = 2000

    // STEP 3
    @State private var selectedInterests: Set<String> = []

    // Static data
    private let colleges = ["BMCC", "Baruch", "Hunter", "City College", "Lehman",
                            "Brooklyn", "Queens", "John Jay"]
    private let majors = ["Computer Science", "Accounting", "Nursing", "Business",
                          "Psychology", "Engineering", "Education", "Art"]
    private let years = ["Freshman", "Sophomore", "Junior", "Senior"]
    private let interests = ["Tech", "Textbooks", "Furniture", "Dorm Essentials",
                             "Clothes", "Art Supplies", "Books", "Calculators"]

    var body: some View {
        NavigationView {
            VStack {
                // Progress indicator
                ProgressView(value: Double(step), total: 3)
                    .tint(.blue)
                    .padding()

                // Step content
                if step == 1 { personalInfoView }
                else if step == 2 { collegeInfoView }
                else { interestsView }

                Spacer()

                // Navigation buttons
                HStack {
                    if step > 1 {
                        Button("Back") { withAnimation { step -= 1 } }
                    }
                    Spacer()
                    Button(step == 3 ? "Finish" : "Next") {
                        handleStepAdvance()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                    .disabled(!canProceed)
                }
                .padding(.horizontal)
                .padding(.bottom, 10)
            }
            .navigationTitle("Sign Up")
            .background(colorScheme == .dark ? Color.black : Color.white)
        }
    }

    // MARK: STEP 1 — Account Info
    private var personalInfoView: some View {
        VStack(spacing: 14) {
            TextField("First Name", text: $firstName)
                .textFieldStyle(.roundedBorder)
            TextField("Last Name", text: $lastName)
                .textFieldStyle(.roundedBorder)
            TextField("CUNY Email", text: $email)
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
                .textFieldStyle(.roundedBorder)
            if showEmailError {
                Text("❌ Email must end with .cuny.edu")
                    .font(.footnote)
                    .foregroundColor(.red)
            }
            TextField("Username", text: $username)
                .textFieldStyle(.roundedBorder)
            HStack {
                if showPassword {
                    TextField("Password", text: $password)
                } else {
                    SecureField("Password", text: $password)
                }
                Button { showPassword.toggle() } label: {
                    Image(systemName: showPassword ? "eye.slash" : "eye")
                        .foregroundColor(.gray)
                }
            }
            .textFieldStyle(.roundedBorder)
            SecureField("Confirm Password", text: $confirmPassword)
                .textFieldStyle(.roundedBorder)
            Toggle("Agree to Terms of Service", isOn: $agreeToTOS)
                .tint(.blue)
            Link("View Terms of Service",
                 destination: URL(string: "https://example.com/tos")!)
                .font(.footnote)
                .foregroundColor(.blue)
                .underline()
        }
        .padding()
    }

    // MARK: STEP 2 — College & DOB
    private var collegeInfoView: some View {
        VStack(spacing: 18) {
            Text("College Information")
                .font(.title3.bold())

            VStack(alignment: .leading, spacing: 6) {
                Text("College").font(.subheadline).foregroundColor(.gray)
                Picker("Select College", selection: $college) {
                    ForEach(colleges, id: \.self) { Text($0) }
                }
                .pickerStyle(.menu)
                .frame(maxWidth: .infinity)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(8)
            }

            VStack(alignment: .leading, spacing: 6) {
                Text("Major").font(.subheadline).foregroundColor(.gray)
                Picker("Select Major", selection: $major) {
                    ForEach(majors, id: \.self) { Text($0) }
                }
                .pickerStyle(.menu)
                .frame(maxWidth: .infinity)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(8)
            }

            VStack(alignment: .leading, spacing: 6) {
                Text("Year Level").font(.subheadline).foregroundColor(.gray)
                Picker("Select Year", selection: $year) {
                    ForEach(years, id: \.self) { Text($0) }
                }
                .pickerStyle(.menu)
                .frame(maxWidth: .infinity)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(8)
            }

            // DOB Picker
            VStack(alignment: .leading, spacing: 8) {
                Text("Date of Birth").font(.subheadline).foregroundColor(.gray)
                HStack(spacing: 10) {
                    Picker("Month", selection: $selectedMonth) {
                        ForEach(1...12, id: \.self) { Text(String(format: "%02d", $0)) }
                    }
                    Picker("Day", selection: $selectedDay) {
                        ForEach(1...31, id: \.self) { Text(String(format: "%02d", $0)) }
                    }
                    Picker("Year", selection: $selectedYear) {
                        ForEach(1980...2025, id: \.self) { Text("\($0)") }
                    }
                }
                .pickerStyle(.menu)
            }

            DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
            DatePicker("Expected Graduation", selection: $gradDate, displayedComponents: .date)
        }
        .padding()
    }

    // MARK: STEP 3 — Interests
    private var interestsView: some View {
        VStack(spacing: 20) {
            Text("Pick up to 5 Interests")
                .font(.title3.bold())
                .padding(.top)
            LazyVGrid(columns: [.init(.adaptive(minimum: 120))], spacing: 14) {
                ForEach(interests, id: \.self) { interest in
                    Button {
                        toggleInterest(interest)
                    } label: {
                        Text(interest)
                            .font(.subheadline.bold())
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                            .background(selectedInterests.contains(interest)
                                        ? Color.blue
                                        : Color.gray.opacity(0.2))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(color: selectedInterests.contains(interest) ? .blue.opacity(0.3) : .clear, radius: 4)
                    }
                    .buttonStyle(.plain)
                }
            }
            Text("\(selectedInterests.count)/5 selected")
                .font(.footnote)
                .foregroundColor(.gray)

            Spacer()
            Button("Finish Setup") { finishSignup() }
                .buttonStyle(.borderedProminent)
                .tint(.blue)
                .font(.headline)
                .disabled(selectedInterests.isEmpty)
                .opacity(selectedInterests.isEmpty ? 0.5 : 1)
        }
        .padding()
    }

    // MARK: Logic
    private func handleStepAdvance() {
        if step == 1 && !email.lowercased().contains("cuny.edu") {
            showEmailError = true
            return
        }
        if step < 3 { withAnimation { step += 1 } }
        else { finishSignup() }
    }

    private func toggleInterest(_ interest: String) {
        withAnimation {
            if selectedInterests.contains(interest) {
                selectedInterests.remove(interest)
            } else if selectedInterests.count < 5 {
                selectedInterests.insert(interest)
            }
        }
    }

    private var canProceed: Bool {
        switch step {
        case 1:
            return !firstName.isEmpty && !lastName.isEmpty &&
                   !username.isEmpty && !password.isEmpty &&
                   password == confirmPassword && agreeToTOS
        case 2:
            return !college.isEmpty && !major.isEmpty && !year.isEmpty
        case 3:
            return !selectedInterests.isEmpty
        default: return false
        }
    }

    private func finishSignup() {
        appState.userFirstName = firstName
        appState.userLastName = lastName
        appState.userEmail = email
        appState.userCollege = college
        appState.userMajor = major
        appState.userYear = year
        appState.userAge = "\(selectedMonth)/\(selectedDay)/\(selectedYear)"
        appState.userInterests = Array(selectedInterests)
        appState.isLoggedIn = true
    }
}

#Preview {
    SignupView()
        .environmentObject(AppState())
}

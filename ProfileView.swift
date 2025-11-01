import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var appState: AppState
    @State private var showingEditProfile = false

    var body: some View {
        NavigationView {
            VStack(spacing: 15) {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 120, height: 120)
                    .foregroundColor(.blue)
                    .padding(.top)

                Text(appState.userFirstName + " " + appState.userLastName)
                    .font(.title2.bold())

                Text(appState.userCollege)
                    .font(.subheadline)
                    .foregroundColor(.gray)

                Divider()

                VStack(alignment: .leading, spacing: 6) {
                    Text("Major: \(appState.userMajor)")
                    Text("Year: \(appState.userYear)")
                    Text("Age: \(appState.userAge)")
                }
                .padding()

                Button("Edit Profile") {
                    showingEditProfile = true
                }
                .buttonStyle(.borderedProminent)
                .tint(.blue)
                .sheet(isPresented: $showingEditProfile) {
                    EditProfileView()
                        .environmentObject(appState)
                }

                Spacer()
            }
            .navigationTitle("Profile")
        }
    }
}

struct EditProfileView: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.dismiss) var dismiss

    @State private var name = ""
    @State private var college = ""
    @State private var major = ""
    @State private var year = ""
    @State private var age = ""

    let colleges = ["BMCC", "Baruch", "Hunter", "City College", "Brooklyn", "Queens", "John Jay", "Lehman"]
    let majors = ["Computer Science", "Accounting", "Nursing", "Business", "Psychology", "Engineering", "Education", "Art"]
    let years = ["Freshman", "Sophomore", "Junior", "Senior"]

    var body: some View {
        NavigationView {
            Form {
                Section("Personal Info") {
                    TextField("Full Name", text: $name)
                    TextField("Age", text: $age)
                }

                Section("Education") {
                    Picker("College", selection: $college) {
                        ForEach(colleges, id: \.self) { Text($0) }
                    }
                    Picker("Major", selection: $major) {
                        ForEach(majors, id: \.self) { Text($0) }
                    }
                    Picker("Year", selection: $year) {
                        ForEach(years, id: \.self) { Text($0) }
                    }
                }

                Section {
                    Button("Save Changes") {
                        appState.userFirstName = name
                        appState.userCollege = college
                        appState.userMajor = major
                        appState.userYear = year
                        appState.userAge = age
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .navigationTitle("Edit Profile")
        }
    }
}

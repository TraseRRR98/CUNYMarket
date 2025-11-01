import SwiftUI
import Combine

final class AppState: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var darkModeEnabled: Bool = false
    @Published var currentStep: Int = 1

    // User Profile
    @Published var userFirstName: String = ""
    @Published var userLastName: String = ""
    @Published var userEmail: String = ""
    @Published var userCollege: String = ""
    @Published var userMajor: String = ""
    @Published var userYear: String = ""
    @Published var userAge: String = ""
    @Published var userInterests: [String] = []

    // Payment info (private)
    @Published var zelle: String = ""
    @Published var venmo: String = ""
    @Published var cashApp: String = ""
    @Published var paypal: String = ""
}

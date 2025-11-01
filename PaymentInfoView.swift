import SwiftUI

struct PaymentInfoView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        NavigationView {
            Form {
                Section("Private Payment Info") {
                    TextField("Zelle", text: $appState.zelle)
                    TextField("Venmo", text: $appState.venmo)
                    TextField("Cash App", text: $appState.cashApp)
                    TextField("PayPal", text: $appState.paypal)
                }

                Text("⚠️ Only visible to you.")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            .navigationTitle("Payment Info")
        }
    }
}

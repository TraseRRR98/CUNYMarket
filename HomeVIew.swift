import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appState: AppState

    // Marketplace items — only MacBook uses a real image
    let items = [
        ProductItem(
            name: "MacBook Air 2015",
            description: "Used 13-inch MacBook Air. 128GB SSD, 8GB RAM. Runs perfectly for school work.",
            price: 200,
            seller: "Daniil",
            college: "BMCC",
            imageName: "macbook_air"
        ),
        ProductItem(
            name: "TI-84 Calculator",
            description: "Graphing calculator — required for calculus. Like new.",
            price: 60,
            seller: "Alex P.",
            college: "Baruch",
            imageName: "default_icon"
        ),
        ProductItem(
            name: "Dorm Desk Lamp",
            description: "LED lamp with USB ports. Ideal for dorm setups.",
            price: 25,
            seller: "Jamie R.",
            college: "Hunter College",
            imageName: "default_icon"
        ),
        ProductItem(
            name: "Business Textbook Set",
            description: "Includes Accounting 101, Business Law, and Economics.",
            price: 45,
            seller: "Maria L.",
            college: "Lehman College",
            imageName: "default_icon"
        )
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // Header
                    Text("CUNYMarket")
                        .font(.largeTitle.bold())
                        .foregroundColor(.blue)

                    Text("Safe Exchange Students Deserve")
                        .foregroundColor(.gray)

                    // Item grid
                    LazyVGrid(columns: [.init(.flexible()), .init(.flexible())], spacing: 16) {
                        ForEach(items) { item in
                            NavigationLink(destination: ItemDetailView(product: item)) {
                                VStack(spacing: 8) {
                                    // Only MacBook shows a real photo
                                    if item.imageName == "macbook_air" {
                                        Image(item.imageName)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 130)
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                    } else {
                                        Image(systemName: "shippingbox.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 80)
                                            .foregroundColor(.blue.opacity(0.6))
                                            .padding(.top, 10)
                                    }

                                    Text(item.name)
                                        .font(.headline)
                                        .multilineTextAlignment(.center)
                                        .lineLimit(2)

                                    Text("$\(Int(item.price))")
                                        .foregroundColor(.green)
                                        .font(.subheadline.bold())
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color(.systemGray6))
                                .cornerRadius(12)
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Marketplace")
        }
    }
}

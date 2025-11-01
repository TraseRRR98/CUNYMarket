import SwiftUI

struct ItemDetailView: View {
    let product: ProductItem

    var body: some View {
        ScrollView {
            Image(product.imageName)
                .resizable()
                .scaledToFit()
                .cornerRadius(12)
                .padding()
            VStack(alignment: .leading, spacing: 10) {
                Text(product.name)
                    .font(.title.bold())
                Text("Seller: \(product.seller) • \(product.college)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text("$\(Int(product.price))")
                    .font(.title2)
                    .foregroundColor(.green)
                Divider()
                Text(product.description)
                    .font(.body)
            }
            .padding()
        }
        .navigationTitle("Item Details")
    }
}

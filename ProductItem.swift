import Foundation

struct ProductItem: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let description: String
    let price: Double
    let seller: String
    let college: String
    let imageName: String
}

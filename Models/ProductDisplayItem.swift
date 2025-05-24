import Foundation

struct ProductDisplayItem {
    let product: Product
    let id: String
    let name: String
    let priceText: String
    let imageURL: URL?

    init(product: Product) {
        self.product = product
        self.id = product.id
        self.name = product.name
        self.priceText = String(format: "$%.2f", product.price)
        self.imageURL = URL(string: product.imageUrl)
    }
}

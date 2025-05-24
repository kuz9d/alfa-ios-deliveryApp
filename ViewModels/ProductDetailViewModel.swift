import Foundation

class ProductDetailViewModel: ProductDetailViewModelProtocol {
    private let product: Product

    init(product: Product) {
        self.product = product
    }

    var title: String { product.name }
    var description: String { product.description }
    var priceText: String {
        String(format: "$%.2f", product.price)
    }
    var imageURL: URL? {
        URL(string: product.imageUrl)
    }
}

class ProductDetailViewModel: ProductDetailViewModelProtocol {
    let product: Product
    private let storage: StorageFacadeProtocol

    init(product: Product, storage: StorageFacadeProtocol) {
        self.product = product
        self.storage = storage
    }

    func addToCart(quantity: Int) {
        let item = CartItem(product: product, quantity: quantity)
        storage.addToCart(item)
    }
}

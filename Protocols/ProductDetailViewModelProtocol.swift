protocol ProductDetailViewModelProtocol {
    var product: Product { get }
    func addToCart(quantity: Int)
}

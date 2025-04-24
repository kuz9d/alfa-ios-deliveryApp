protocol LoginViewModelProtocol {
    func login(username: String, password: String) -> Bool
}

protocol ProductListViewModelProtocol {
    var products: [Product] { get }
    func fetchProducts()
}

protocol ProductDetailViewModelProtocol {
    var product: Product { get }
    func addToCart(quantity: Int)
}

protocol CartViewModelProtocol {
    var items: [CartItem] { get }
    var totalAmount: Double { get }
    func removeItem(at index: Int)
}

protocol CheckoutViewModelProtocol {
    func placeOrder() -> Order
}

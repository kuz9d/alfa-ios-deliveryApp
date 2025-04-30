protocol ProductListViewModelProtocol {
    var products: [Product] { get }
    func fetchProducts()
}

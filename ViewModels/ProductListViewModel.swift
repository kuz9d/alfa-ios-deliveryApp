class ProductListViewModel: ProductListViewModelProtocol {
    private(set) var products: [Product] = []

    func fetchProducts() {
        products = [
            Product(id: "1", name: "Apple", description: "Fresh apple", price: 1.0, imageUrl: ""),
            Product(id: "2", name: "Milk", description: "Dairy milk", price: 2.0, imageUrl: "")
        ]
    }
}

class CartViewModel: CartViewModelProtocol {
    private let storage: StorageFacadeProtocol

    init(storage: StorageFacadeProtocol) {
        self.storage = storage
    }

    var items: [CartItem] {
        storage.cartItems
    }

    var totalAmount: Double {
        items.reduce(0) { $0 + ($1.product.price * Double($1.quantity)) }
    }

    func removeItem(at index: Int) {
        storage.removeItem(at: index)
    }
}

class StorageFacade: StorageFacadeProtocol {
    private(set) var cartItems: [CartItem] = []

    func addToCart(_ item: CartItem) {
        cartItems.append(item)
    }

    func removeItem(at index: Int) {
        guard cartItems.indices.contains(index) else { return }
        cartItems.remove(at: index)
    }

    func clearCart() {
        cartItems.removeAll()
    }
}

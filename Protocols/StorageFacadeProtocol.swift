protocol StorageFacadeProtocol {
    var cartItems: [CartItem] { get }
    func addToCart(_ item: CartItem)
    func removeItem(at index: Int)
    func clearCart()
}

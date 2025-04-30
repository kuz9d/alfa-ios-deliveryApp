protocol CartViewModelProtocol {
    var items: [CartItem] { get }
    var totalAmount: Double { get }
    func removeItem(at index: Int)
}

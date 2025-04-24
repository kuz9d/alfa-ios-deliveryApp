import Foundation

class CheckoutViewModel: CheckoutViewModelProtocol {
    private let storage: StorageFacadeProtocol
    private let user: User

    init(user: User, storage: StorageFacadeProtocol) {
        self.user = user
        self.storage = storage
    }

    func placeOrder() -> Order {
        let items = storage.cartItems
        let total = items.reduce(0) { $0 + ($1.product.price * Double($1.quantity)) }
        let order = Order(id: UUID().uuidString, items: items, totalAmount: total, userId: user.id, date: Date())
        storage.clearCart()
        return order
    }
}

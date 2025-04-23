import Foundation

struct Order {
    let id: String
    let items: [CartItem]
    let totalAmount: Double
    let userId: String
    let date: Date
}

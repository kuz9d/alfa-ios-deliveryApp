import Foundation

protocol ProductDetailViewModelProtocol {
    var title: String { get }
    var description: String { get }
    var priceText: String { get }
    var imageURL: URL? { get }
}

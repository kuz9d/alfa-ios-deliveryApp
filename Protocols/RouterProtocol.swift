import Foundation

protocol RouterProtocol {
    func showProductList()
    func showProductDetail(for product: Product)
    func showBDUIScreen(endpoint: URL)
}

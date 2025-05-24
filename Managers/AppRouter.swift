import UIKit

class AppRouter: RouterProtocol {
    private let navigation: UINavigationController

    init(navigation: UINavigationController) {
        self.navigation = navigation
    }

    func showProductList() {
        guard let vm = ProductListViewModel() else { return }
        let vc = ProductListViewController(viewModel: vm, router: self)
        navigation.pushViewController(vc, animated: true)
    }
    
    func showProductDetail(for product: Product) {
        let vm = ProductDetailViewModel(product: product)
        let vc = ProductDetailViewController(viewModel: vm)
        navigation.pushViewController(vc, animated: true)
    }
}

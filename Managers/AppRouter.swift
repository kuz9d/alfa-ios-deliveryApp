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
        let vc = ProductDetailViewController(viewModel: vm, router: self)
        navigation.pushViewController(vc, animated: true)
    }
    
    func showBDUIScreen(endpoint: URL) {
        let login    = ProcessInfo.processInfo.bduiLogin
        let password = ProcessInfo.processInfo.bduiPassword

        guard !login.isEmpty, !password.isEmpty else {
            fatalError("not set environment variables")
        }

        let vc = BDUIScreenViewController(endpoint: endpoint,login: login, password: password)
        navigation.pushViewController(vc, animated: true)
    }

}

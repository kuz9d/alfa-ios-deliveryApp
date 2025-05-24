import UIKit

class ProductListViewController: UIViewController, TableManagerDelegate {

    private let viewModel: ProductListViewModelProtocol
    private let router: RouterProtocol
    private var tableManager: TableManagerProtocol!

    private lazy var productListView = ProductListView()

    init(viewModel: ProductListViewModelProtocol, router: RouterProtocol) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = productListView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        productListView.tableView.rowHeight = UITableView.automaticDimension
        productListView.tableView.estimatedRowHeight = 100
        
        setupTableManager()
        bindViewModel()
        viewModel.fetchNextPage()
    }

    private func setupTableManager() {
        tableManager = TableManager(tableView: productListView.tableView)
        tableManager.delegate = self

        tableManager.onWillDisplayLastCell = { [weak self] in
            self?.viewModel.fetchNextPage()
        }

        productListView.refreshControl.addTarget(self,
                                                 action: #selector(refreshPulled),
                                                 for: .valueChanged)
    }

    private func bindViewModel() {
        viewModel.didChange = { [weak self] in
            guard let self = self else { return }
            self.tableManager.setItems(self.viewModel.items)
            self.tableManager.reloadData()
            self.productListView.refreshControl.endRefreshing()
        }

        viewModel.didFail = { [weak self] error in
            print("Error: \(error.localizedDescription)")
            self?.productListView.refreshControl.endRefreshing()
        }
    }

    @objc private func refreshPulled() {
        viewModel.refresh()
    }

    func didSelectItem(_ item: ProductDisplayItem) {
        router.showProductDetail(for: item.product)
    }
}

import UIKit

class TableManager: NSObject, TableManagerProtocol {
    weak var delegate: TableManagerDelegate?
    private var items: [ProductDisplayItem] = []
    private weak var tableView: UITableView?

    var onWillDisplayLastCell: (() -> Void)?

    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProductViewCell.self,
                           forCellReuseIdentifier: ProductViewCell.reuseId)
    }

    func setItems(_ items: [ProductDisplayItem]) {
        self.items = items
    }

    func reloadData() {
        tableView?.reloadData()
    }
}

extension TableManager: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ProductViewCell.reuseId,
                for: indexPath
        ) as? ProductViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: items[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectItem(items[indexPath.row])
    }

    func tableView(_ tableView: UITableView,
                   willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        if indexPath.row == items.count - 1 {
            onWillDisplayLastCell?()
        }
    }
}

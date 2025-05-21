protocol TableManagerProtocol {
    var delegate: TableManagerDelegate? { get set }
    var onWillDisplayLastCell: (() -> Void)? { get set }
    func setItems(_ items: [ProductDisplayItem])
    func reloadData()
}

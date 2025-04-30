protocol ProductListViewModelProtocol: AnyObject {
    var items: [ProductDisplayItem] { get }
    var isLoading: Bool { get }
    var didChange: (() -> Void)? { get set }
    var didFail: ((Error) -> Void)? { get set }
    func fetchNextPage()
    func refresh()
}

protocol CacheServiceProtocol {
    func loadProducts(page: Int) -> [Product]?
    func saveProducts(_ products: [Product], page: Int)
    func invalidateCache()
}

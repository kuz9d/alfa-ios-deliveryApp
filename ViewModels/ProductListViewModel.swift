import Foundation

class ProductListViewModel: ProductListViewModelProtocol {
    private(set) var items: [ProductDisplayItem] = [] {
        didSet { didChange?() }
    }
    private(set) var isLoading: Bool = false {
        didSet { didChange?() }
    }
    private var productsByPage: [Int: [Product]] = [:]
    private var currentPage = 0
    private let pageSize = 10
    private let session: URLSession
    private let baseURL: URL
    private let cacheService: CacheServiceProtocol

    var didChange: (() -> Void)?
    var didFail: ((Error) -> Void)?

    init?(session: URLSession = .shared,
          baseURL: URL? = nil,
          cacheService: CacheServiceProtocol = FileCacheService()) {
        guard let url = baseURL ?? URL(string: "https://fakestoreapi.com/products") else {
            return nil
        }
        self.session = session
        self.baseURL = url
        self.cacheService = cacheService
    }

    func fetchNextPage() {
        guard !isLoading else { return }
        let next = currentPage + 1

        if let cached = cacheService.loadProducts(page: next) {
            appendProducts(cached)
            return
        }

        isLoading = true
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)!
        components.queryItems = [
            URLQueryItem(name: "limit", value: String(pageSize)),
            URLQueryItem(name: "offset", value: String((next - 1) * pageSize))
        ]

        guard let url = components.url else {
            didFail?(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
            return
        }
        let request = URLRequest(url: url)

        session.dataTask(with: request) { [weak self] data, _, error in
            defer { DispatchQueue.main.async { self?.isLoading = false } }
            if let error = error {
                DispatchQueue.main.async { self?.didFail?(error) }
                return
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    self?.didFail?(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data"]))
                }
                return
            }
            do {
                let apiProducts = try JSONDecoder().decode([APIProduct].self, from: data)
                let domain = apiProducts.map { api in
                    Product(
                        id: String(api.id),
                        name: api.title,
                        description: api.description,
                        price: api.price,
                        imageUrl: api.image
                    )
                }
                DispatchQueue.main.async {
                    self?.cacheService.saveProducts(domain, page: next)
                    self?.appendProducts(domain)
                }
            } catch {
                DispatchQueue.main.async { self?.didFail?(error) }
            }
        }.resume()
    }

    func refresh() {
        cacheService.invalidateCache()
        items = []
        currentPage = 0
        productsByPage = [:]
        fetchNextPage()
    }

    private func appendProducts(_ products: [Product]) {
        currentPage += 1
        productsByPage[currentPage] = products
        let newItems = products.map { ProductDisplayItem(product: $0) }
        items.append(contentsOf: newItems)
    }
}

import Foundation

class FileCacheService: CacheServiceProtocol {
    private let cacheURL: URL
    private let ttl: TimeInterval = 3600

    init() {
        let fm = FileManager.default
        let cachesDir = fm.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        cacheURL = cachesDir.appendingPathComponent("products_cache.json")
    }

    func loadProducts(page: Int) -> [Product]? {
        guard let data = try? Data(contentsOf: cacheURL),
              let wrapper = try? JSONDecoder().decode(CacheWrapper.self, from: data)
        else { return nil }

        if Date().timeIntervalSince(wrapper.timestamp) > ttl {
            invalidateCache()
            return nil
        }
        return wrapper.pages[String(page)]
    }

    func saveProducts(_ products: [Product], page: Int) {
        var wrapper = (try? JSONDecoder().decode(CacheWrapper.self, from: (try? Data(contentsOf: cacheURL)) ?? Data())) ?? CacheWrapper(timestamp: Date(), pages: [:])
        wrapper.timestamp = Date()
        wrapper.pages[String(page)] = products
        if let data = try? JSONEncoder().encode(wrapper) {
            try? data.write(to: cacheURL)
        }
    }

    func invalidateCache() {
        try? FileManager.default.removeItem(at: cacheURL)
    }
}

import Foundation

struct CacheWrapper: Codable {
    var timestamp: Date
    var pages: [String: [Product]]
}

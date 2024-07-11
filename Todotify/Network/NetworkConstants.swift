import Foundation

struct NetworkConstants {
    static let defaultBaseURL = URL(string: "https://api.unsplash.com")!
    static let host = "api.unsplash.com"
    static let schema = "https"
}

enum HttpMethods: String {
    case post = "POST"
    case get = "GET"
    case delete = "DELETE"
}

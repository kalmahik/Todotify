import Foundation

struct NetworkConstants {
    static let defaultBaseURL = URL(string: "https://hive.mrdekk.ru")!
    static let host = "hive.mrdekk.ru"
    static let schema = "https"
}

struct HeaderKeys {
    static let bearer = "Bearer"
    static let authorization = "Authorization"
    static let lastRevision = "X-Last-Known-Revision"
}

struct PathKeys {
    static let listOfTodos = "/todo/list"
}

enum HttpMethods: String {
    case post = "POST"
    case get = "GET"
    case delete = "DELETE"
    case put = "PUT"
    case patch = "PATCH"
}

enum StatusCode: Int {
    case OK = 200
    case SYNC_ERROR = 400
    case NOT_FOUND = 404
}

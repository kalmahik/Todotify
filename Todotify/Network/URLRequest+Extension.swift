//
//  URLRequest+Extension.swift
//  Todotify
//
//  Created by Murad Azimov on 17.07.2024.
//

import Foundation

extension URLRequest {
    static func makeRequest(
        httpMethod: String? = HttpMethods.get.rawValue,
        path: String, host: String? = NetworkConstants.host,
        queryItems: [URLQueryItem]? = [],
        headers: [(String, String)]? = [],
        body: Data? = nil
    ) -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = NetworkConstants.schema
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = queryItems
        var request = URLRequest(url: urlComponents.url ?? NetworkConstants.defaultBaseURL)
        request.httpMethod = httpMethod
        let token = "\(token)" // НАПИШИ ТУТ СВОЙ ТОКЕН
        request.setValue("\(HeaderKeys.bearer) \(token)", forHTTPHeaderField: HeaderKeys.authorization)
        for header in headers ?? [] {
            request.setValue(header.1, forHTTPHeaderField: header.0)
        }
        request.httpBody = body
        return request
    }
}

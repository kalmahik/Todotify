//
//  URLSession+Eхtentions.swift
//  Todotify
//
//  Created by Murad Azimov on 11.07.2024.
//

import Foundation

extension URLSession {
    func dataTask(for request: URLRequest) async throws -> (Data, URLResponse) {
        var task: URLSessionDataTask?
        let onCancel = { task?.cancel() }

        return try await withTaskCancellationHandler(operation: {
            try await withCheckedThrowingContinuation { continuation in
                task = dataTask(with: request) { data, response, error in
                    if let error {
                        continuation.resume(throwing: error)
                    } else if let data, let response {
                        continuation.resume(returning: (data, response))
                    } else {
                        continuation.resume(throwing: URLError(.unknown))
                    }
                }
                task?.resume()
            }
        }, onCancel: {
            onCancel()
        })
    }
}

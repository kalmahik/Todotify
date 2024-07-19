//
//  DefaultNetworkingService.swift
//  Todotify
//
//  Created by Murad Azimov on 17.07.2024.
//

import CocoaLumberjackSwift
import Foundation

final actor DefaultNetworkingService: NetworkService, ObservableObject {

    static let shared = DefaultNetworkingService()

    private var revision = 0

    private init() {}

    private lazy var decoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    private lazy var encoder = {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()

    func fetchTodos() async -> [TodoItem] {
        let request = URLRequest.makeRequest(path: PathKeys.listOfTodos)

        let response: ListResponse? = await fetch(request: request)

        return (response?.list ?? []).map { TodoItem(from: $0) }
    }

    func fetchCreateTodo(todo: TodoItem) async -> TodoItem? {
        let body = ListRequest(element: TodoItemDTO(from: todo))
        let jsonBody = try? encoder.encode(body)

        let request = URLRequest.makeRequest(
            httpMethod: HttpMethods.post.rawValue,
            path: PathKeys.listOfTodos,
            headers: [(HeaderKeys.lastRevision, "\(revision)")],
            body: jsonBody
        )

        let response: ElementResponse? = await fetch(request: request)
        return response.map { TodoItem(from: $0.element) }
    }

    func fetchEditTodo(todo: TodoItem) async -> TodoItem? {
        let body = ListRequest(element: TodoItemDTO(from: todo))
        let jsonBody = try? encoder.encode(body)

        let request = URLRequest.makeRequest(
            httpMethod: HttpMethods.put.rawValue,
            path: "\(PathKeys.listOfTodos)/\(todo.id)",
            headers: [(HeaderKeys.lastRevision, "\(revision)")],
            body: jsonBody
        )

        let response: ElementResponse? = await fetch(request: request)
        return response.map { TodoItem(from: $0.element) }
    }

    func fetchDeleteTodo(todo: TodoItem) async -> TodoItem? {
        let request = URLRequest.makeRequest(
            httpMethod: HttpMethods.delete.rawValue,
            path: "\(PathKeys.listOfTodos)/\(todo.id)",
            headers: [(HeaderKeys.lastRevision, "\(revision)")]
        )

        let response: ElementResponse? = await fetch(request: request)
        return response.map { TodoItem(from: $0.element) }
    }

    func fetchTodo(todoId: String) async -> TodoItem? {
        let request = URLRequest.makeRequest(path: "\(PathKeys.listOfTodos)/\(todoId)")

        let response: ElementResponse? = await fetch(request: request)
        return response.map { TodoItem(from: $0.element) }
    }

    private func fetch<T: Response>(request: URLRequest) async -> T? {
        do {
            let (data, response) = try await URLSession.shared.dataTask(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                DDLogError("Unknown error")
                return nil
            }

            if httpResponse.statusCode == StatusCode.OK.rawValue {
                let result = try decoder.decode(T.self, from: data)
                revision = result.revision
                return result
            }

            if httpResponse.statusCode == StatusCode.SYNC_ERROR.rawValue {
                DDLogError("\(httpResponse.statusCode)")
                return nil
            }

            return nil
        } catch let error {
            DDLogError("\(error.localizedDescription)")
            return nil
        }
    }
}

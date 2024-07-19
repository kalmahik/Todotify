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

    private var isDirty = false

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

        let response: ListResponse? = await fetch(request: request, ignoreDirtyLogic: true)

        return (response?.list ?? []).map { TodoItem(from: $0) }
    }

    func fetchTodo(todoId: String) async -> TodoItem? {
        let request = URLRequest.makeRequest(path: "\(PathKeys.listOfTodos)/\(todoId)")

        let response: ElementResponse? = await fetch(request: request)
        return response.map { TodoItem(from: $0.element) }
    }

    func fetchCreateTodo(todo: TodoItem) async -> TodoItem? {
        let body = ElementRequest(element: TodoItemDTO(from: todo))
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
        let body = ElementRequest(element: TodoItemDTO(from: todo))
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

    private func fetchSync(todos: [TodoItem]) async -> [TodoItem] {
        let list = todos.map { TodoItemDTO(from: $0) }
        let body = ListRequest(list: list)
        let jsonBody = try? encoder.encode(body)

        let request = URLRequest.makeRequest(
            httpMethod: HttpMethods.patch.rawValue,
            path: PathKeys.listOfTodos,
            headers: [(HeaderKeys.lastRevision, "\(revision)")],
            body: jsonBody
        )

        let response: ListResponse? = await fetch(request: request, ignoreDirtyLogic: true)
        return (response?.list ?? []).map { TodoItem(from: $0) }
    }

    private func fetch<T: Response>(request: URLRequest, ignoreDirtyLogic: Bool? = false) async -> T? {
        do {
            if isDirty && ignoreDirtyLogic == false {
                DDLogInfo("START SYNC")
                let todos = Store.shared.todos
                _ = await fetchTodos() // чтобы получить актуальную ревизию
                let updatedTodos = await fetchSync(todos: todos)
                await MainActor.run {
                    Store.shared.replace(todos: updatedTodos)
                }
                isDirty = false
                DDLogInfo("STOP SYNC")
            }

            let (data, response) = try await URLSession.shared.dataTask(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                DDLogError("BAD RESPONSE: \(response)")
                return nil
            }

            if httpResponse.statusCode == StatusCode.OK.rawValue {
                let result = try decoder.decode(T.self, from: data)
                revision = result.revision
                DDLogInfo("NEW REVISION: \(revision)")
                return result
            }

            if httpResponse.statusCode == StatusCode.SYNC_ERROR.rawValue {
                isDirty = true
                DDLogWarn("SET DIRTY: \(httpResponse.statusCode)")
                return nil
            }

            return nil
        } catch let error {
            DDLogError("\(error.localizedDescription)")
            return nil
        }
    }
}

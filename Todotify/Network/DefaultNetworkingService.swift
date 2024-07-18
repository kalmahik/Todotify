//
//  BaseNetworkService.swift
//  Todotify
//
//  Created by Murad Azimov on 17.07.2024.
//

import CocoaLumberjackSwift
import Foundation

actor DefaultNetworkingService: NetworkService, ObservableObject {

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

    func fetchListOfTodos() async -> [TodoItem] {
        do {
            let request = URLRequest.makeRequest(path: PathKeys.listOfTodos)
            let (data, response) = try await URLSession.shared.dataTask(for: request)

            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == StatusCode.OK.rawValue {
                    let listResponse = try decoder.decode(ListResponse.self, from: data)
                    revision = listResponse.revision
                    return listResponse.list.map { TodoItem(from: $0) }
                }
                return []
            }
            return []
        } catch let error {
            DDLogWarn("\(error.localizedDescription)")
            return []
        }
    }

    func fetchCreateTodo(todo: TodoItem) async -> TodoItem? {
        do {
            let body = ListRequest(element: TodoItemDTO(from: todo))
            let jsonBody = try encoder.encode(body)

            let request = URLRequest.makeRequest(
                httpMethod: HttpMethods.post.rawValue,
                path: PathKeys.listOfTodos,
                headers: [(HeaderKeys.lastRevision, "\(revision)")],
                body: jsonBody
            )

            let (data, response) = try await URLSession.shared.dataTask(for: request)

            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == StatusCode.OK.rawValue {
                    let listResponse = try decoder.decode(ElementResponse.self, from: data)
                    revision = listResponse.revision
                    return TodoItem(from: listResponse.element)
                }

                if httpResponse.statusCode == 400 {
                    DDLogError("\(httpResponse.statusCode)")
                    DDLogError("\(response)")
                }
                return nil
            }

            return nil
        } catch let error {
            DDLogWarn("\(error.localizedDescription)")
            return nil
        }
    }

    func fetchEditTodo(todo: TodoItem) async -> TodoItem? {
        do {
            let body = ListRequest(element: TodoItemDTO(from: todo))
            let jsonBody = try encoder.encode(body)

            let request = URLRequest.makeRequest(
                httpMethod: HttpMethods.put.rawValue,
                path: "\(PathKeys.listOfTodos)/\(todo.id)",
                headers: [(HeaderKeys.lastRevision, "\(revision)")],
                body: jsonBody
            )

            let (data, response) = try await URLSession.shared.dataTask(for: request)

            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == StatusCode.OK.rawValue {
                    let listResponse = try decoder.decode(ElementResponse.self, from: data)
                    revision = listResponse.revision
                    return TodoItem(from: listResponse.element)
                }
                if httpResponse.statusCode == 400 {
                    DDLogError("\(httpResponse.statusCode)")
                    DDLogError("\(response)")
                }
                return nil
            }
            return nil
        } catch let error {
            DDLogWarn("\(error.localizedDescription)")
            return nil
        }
    }

    func fetchDeleteTodo(todo: TodoItem) async -> TodoItem? {
        do {
            let request = URLRequest.makeRequest(
                httpMethod: HttpMethods.delete.rawValue,
                path: "\(PathKeys.listOfTodos)/\(todo.id)",
                headers: [(HeaderKeys.lastRevision, "\(revision)")]
            )

            let (data, response) = try await URLSession.shared.dataTask(for: request)

            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == StatusCode.OK.rawValue {
                    let listResponse = try decoder.decode(ElementResponse.self, from: data)
                    revision = listResponse.revision
                    return TodoItem(from: listResponse.element)
                }
                if httpResponse.statusCode == 400 {
                    DDLogError("\(httpResponse.statusCode)")
                    DDLogError("\(response)")
                }
                return nil
            }
            return nil
        } catch _ {
            return nil
        }
    }

    func fetchTodo(todoId: String) async -> TodoItem? {
        do {
            let request = URLRequest.makeRequest(path: "\(PathKeys.listOfTodos)/\(todoId)")

            let (data, response) = try await URLSession.shared.dataTask(for: request)

            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == StatusCode.OK.rawValue {
                    let listResponse = try decoder.decode(ElementResponse.self, from: data)
                    revision = listResponse.revision
                    return TodoItem(from: listResponse.element)
                }
                return nil
            }
            return nil
        } catch let error {
            DDLogWarn("\(error.localizedDescription)")
            return nil
        }
    }
}

//
//  Store.swift
//  Todotify
//
//  Created by kalmahik on 18.06.2024.
//

import CocoaLumberjackSwift
import SwiftUI

final class Store: ObservableObject {
    static let shared = Store()

    private init() {}

    @Published var todos: [TodoItem] = []

    private let networkService = DefaultNetworkingService.shared

    @Published var categories: [Category] = [
        Category(name: "Работа", hexColor: Color.red.toHex()),
        Category(name: "Учеба", hexColor: Color.blue.toHex()),
        Category(name: "Хобби", hexColor: Color.green.toHex()),
        Category.defaultCategory
    ]

    func replace(todos: [TodoItem]) {
        self.todos = todos
    }

    func add(todo: TodoItem) {
        if let existedIndex = todos.firstIndex(where: { $0.id == todo.id }) {
            todos[existedIndex] = todo
            DDLogInfo("TODO EXIST, UPDATING")

            Task {
                _ = await networkService.fetchEditTodo(todo: todo)
            }
        } else {
            todos.append(todo)
            DDLogInfo("TODO ADDED")

            Task {
                _ = await networkService.fetchCreateTodo(todo: todo)
            }
        }
    }

    func removeTodo(todo: TodoItem) {
        todos.removeAll { $0.id == todo.id }
        DDLogInfo("TODO REMOVED")

        Task {
            _ = await networkService.fetchDeleteTodo(todo: todo)
        }
    }

    func add(category: Category) {
        if let existedIndex = categories.firstIndex(where: { $0.name == category.name }) {
            categories[existedIndex] = category
            DDLogInfo("CATEGORY UPDATED")
        } else {
            categories.append(category)
            DDLogInfo("NEW CATEGORY CREATED")
        }
    }
}

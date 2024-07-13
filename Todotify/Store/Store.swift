//
//  Store.swift
//  Todotify
//
//  Created by kalmahik on 18.06.2024.
//

import CocoaLumberjackSwift
import SwiftUI

final class Store: ObservableObject {
    @Published var todos: [TodoItem] = MockTodoItems.items
    let consoleLogger = DDOSLogger.sharedInstance

    @Published var categories: [Category] = [
        Category(name: "Работа", hexColor: Color.red.toHex()),
        Category(name: "Учеба", hexColor: Color.blue.toHex()),
        Category(name: "Хобби", hexColor: Color.green.toHex()),
        Category.defaultCategory
    ]

    func add(todo: TodoItem) {
        if let existedIndex = todos.firstIndex(where: { $0.id == todo.id }) {
            todos[existedIndex] = todo
            DDLogInfo("TODO EXIST, UPDATING")
        } else {
            todos.append(todo)
            DDLogInfo("TODO ADDED")
        }
    }

    func removeTodo(by id: String) {
        todos.removeAll { $0.id == id }
        DDLogInfo("TODO REMOVED")
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

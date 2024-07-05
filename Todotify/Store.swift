//
//  Store.swift
//  Todotify
//
//  Created by kalmahik on 18.06.2024.
//

import SwiftUI

final class Store: ObservableObject {
    @Published var todos: [TodoItem] = MockTodoItems.items
    
    @Published var categories: [Category] = [
        Category(name: "Work", hexColor: Color.red.toHexString()),
        Category(name: "Personal", hexColor: Color.green.toHexString()),
        Category(name: "Shopping", hexColor: Color.blue.toHexString()),
        Category(name: "Fitness", hexColor: Color.yellow.toHexString())
    ]
    
    func add(todo: TodoItem) {
        if let existedIndex = todos.firstIndex(where: { $0.id == todo.id }) {
            todos[existedIndex] = todo
        } else {
            todos.append(todo)
        }
    }
    
    func removeTodo(by id: String) {
        todos.removeAll { $0.id == id }
    }
}

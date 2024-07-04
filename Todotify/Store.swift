//
//  Store.swift
//  Todotify
//
//  Created by kalmahik on 18.06.2024.
//

import Foundation

final class Store: ObservableObject {
    @Published var todos: [TodoItem] = MockTodoItems.items
    
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

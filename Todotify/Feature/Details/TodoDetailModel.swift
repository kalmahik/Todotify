//
//  CalendarModel.swift
//  Todotify
//
//  Created by Murad Azimov on 04.07.2024.
//

import Foundation

final class TodoDetailModel {
    private let store: Store

    init(store: Store) {
        self.store = store
    }

    func getTodos() -> [TodoItem] {
        store.todos
    }

    func create(todo: TodoItem) {
        store.add(todo: todo)
    }

    func edit(todo: TodoItem) {
        store.add(todo: todo)
    }

    func setCompleted(todo: TodoItem, isCompleted: Bool) {
        let updatedTodo = todo.copy(isCompleted: isCompleted)
        store.add(todo: updatedTodo)
    }

    func removeTodo(todo: TodoItem) {
        store.removeTodo(todo: todo)
    }

    func getCategories() -> [Category] {
        store.categories
    }
}

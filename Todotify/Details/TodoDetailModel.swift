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
    
    func add(todo: TodoItem) {
        store.add(todo: todo)
    }
    
    func setCompleted(todo: TodoItem, isCompleted: Bool) {
        let updatedTodo = TodoItem(
            id: todo.id,
            text: todo.text,
            importance: todo.importance,
            deadline: todo.deadline,
            isCompleted: isCompleted,
            createdAt: todo.createdAt,
            editedAt: todo.editedAt,
            hexColor: todo.hexColor
        )
        store.add(todo: updatedTodo)
    }
    
    func removeTodo(by id: String) {
        store.removeTodo(by: id)
    }
}

//
//  TodoDetailViewModel.swift
//  Todotify
//
//  Created by Murad Azimov on 26.06.2024.
//

import SwiftUI
import Combine

final class TodoDetailViewModel: ObservableObject {
    @Published var text: String
    @Published var importance: Importance
    @Published var deadline: Date
    @Published var isDeadlineEnabled: Bool
    @Published var todoItem: TodoItem?
    
    private var todoDetailModel: FileCache
    
    init(todoItem: TodoItem?, todoDetailModel: FileCache) {
        self.todoItem = todoItem
        self.todoDetailModel = todoDetailModel
        self.text = todoItem?.text ?? ""
        self.importance = todoItem?.importance ?? .usual
        self.deadline = todoItem?.deadline ?? Date().addingTimeInterval(24 * 60 * 60) // TODO: переделать на календарь
        self.isDeadlineEnabled = todoItem?.deadline != nil
    }
    
    func saveTodo() {
        let todo = TodoItem(
            id: todoItem?.id ?? UUID().uuidString,
            text: text,
            importance: importance,
            deadline: isDeadlineEnabled ? deadline : nil,
            isCompleted: todoItem?.isCompleted ?? false,
            createdAt: todoItem?.createdAt ?? Date(),
            editedAt: Date()
        )
        todoDetailModel.add(todo: todo)
    }
    
    func deleteTodo() {
        let todo = TodoItem(
            id: todoItem?.id ?? UUID().uuidString,
            text: text,
            importance: importance,
            deadline: isDeadlineEnabled ? deadline : nil,
            isCompleted: todoItem?.isCompleted ?? false,
            createdAt: todoItem?.createdAt ?? Date(),
            editedAt: Date()
        )
        todoDetailModel.removeTodo(by: todo.id)
    }
}

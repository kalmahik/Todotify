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
    @Published var isPickerShowed: Bool
    @Published var isDeadlineEnabled: Bool
    @Published var todoItem: TodoItem?
    
    private var todoDetailModel: FileCache
    
    init(todoItem: TodoItem?, todoDetailModel: FileCache) {
        self.todoItem = todoItem
        self.todoDetailModel = todoDetailModel
        self.text = todoItem?.text ?? ""
        self.importance = todoItem?.importance ?? .usual
        self.deadline = todoItem?.deadline ?? Date().addingTimeInterval(24 * 60 * 60) // TODO: переделать на календарь
        self.isPickerShowed = false
        self.isDeadlineEnabled = todoItem?.deadline != nil
    }
    
    func saveTodo() {
        let todo = TodoItem(
            id: todoItem?.id,
            text: text,
            importance: importance,
            deadline: isPickerShowed ? deadline : nil,
            isCompleted: todoItem?.isCompleted,
            createdAt: todoItem?.createdAt,
            editedAt: Date()
        )
        todoDetailModel.add(todo: todo)
    }
    
    func deleteTodo() {
        guard let id = todoItem?.id else { return }
        todoDetailModel.removeTodo(by: id)
    }
    
    func completeTodo() {
        let todo = TodoItem(
            id: todoItem?.id,
            text: text,
            importance: todoItem?.importance,
            deadline: todoItem?.deadline,
            isCompleted: true,
            createdAt: todoItem?.createdAt,
            editedAt: todoItem?.editedAt
        )
        todoDetailModel.add(todo: todo)
    }
    
    func getDeadlineString() -> String? {
        isDeadlineEnabled ? deadline.asHumanString() : nil
    }
    
    func pickerToggle() {
        isPickerShowed = !isPickerShowed
    }
    
    func showPicker() {
        isPickerShowed = true
    }
    
    func deadlineToggle() {
        isDeadlineEnabled = !isDeadlineEnabled
    }
}

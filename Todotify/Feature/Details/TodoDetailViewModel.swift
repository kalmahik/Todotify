//
//  TodoDetailViewModel.swift
//  Todotify
//
//  Created by Murad Azimov on 26.06.2024.
//

import Combine
import SwiftUI

final class TodoDetailViewModel: ObservableObject {
    @Published var text: String
    @Published var importance: Importance
    @Published var hexColor: Color
    @Published var deadline: Date
    @Published var isDatePickerShowed: Bool
    @Published var isDeadlineEnabled: Bool
    @Published var todoItem: TodoItem?
    @Published var category: Category

    private var todoDetailModel: TodoDetailModel

    init(todoDetailModel: TodoDetailModel, todoItem: TodoItem?) {
        self.todoItem = todoItem
        self.todoDetailModel = todoDetailModel
        self.text = todoItem?.text ?? ""
        self.importance = todoItem?.importance ?? .basic
        self.hexColor = Color(hex: todoItem?.hexColor ?? Color.clear.toHex()) ?? .clear // отрефакторить!!
        self.deadline = todoItem?.deadline ?? Date().addingTimeInterval(24 * 60 * 60) // TODO: переделать на календарь
        self.isDatePickerShowed = false
        self.isDeadlineEnabled = todoItem?.deadline != nil
        self.category = todoItem?.category ?? Category.defaultCategory
    }

    func saveTodo() {
        let todo = TodoItem(
            id: todoItem?.id,
            text: text,
            importance: importance,
            deadline: isDeadlineEnabled ? deadline : nil,
            isCompleted: todoItem?.isCompleted,
            createdAt: todoItem?.createdAt,
            editedAt: Date(),
            hexColor: hexColor.toHex(),
            category: category
        )
        if todoItem?.id != nil {
            todoDetailModel.edit(todo: todo)
        } else {
            todoDetailModel.create(todo: todo)
        }
    }

    func deleteTodo() {
        guard let todoItem else { return }
        todoDetailModel.removeTodo(todo: todoItem)
    }

    func completeToggle() {
        if let todoItem {
            let updatedTodo = todoItem.copy(isCompleted: !(todoItem.isCompleted))
            todoDetailModel.edit(todo: updatedTodo)
        }
    }

    func getDeadlineString() -> String? {
        isDeadlineEnabled ? deadline.asHumanString() : nil
    }

    func datePickerToggle() {
        isDatePickerShowed = !isDatePickerShowed
    }

    func showDatePicker() {
        isDatePickerShowed = true
    }

    func deadlineToggle() {
        isDeadlineEnabled = !isDeadlineEnabled
    }

    func isSaveDisabled() -> Bool {
        text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    func getCategories() -> [Category] {
        todoDetailModel.getCategories()
    }
}

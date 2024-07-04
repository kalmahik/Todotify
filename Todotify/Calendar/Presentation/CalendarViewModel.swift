//
//  CalendarViewModel.swift
//  Todotify
//
//  Created by Murad Azimov on 04.07.2024.
//

import Foundation

typealias CustomBinding<T> = (T) -> Void
typealias TodosGrouped = [(String, [TodoItem])]

final class CalendarViewModel {
    var todosBinding: CustomBinding<TodosGrouped>?

    private let model: CalendarModel

    init(for model: CalendarModel) {
        self.model = model
    }
    
    func loadTodos() {
        self.todosBinding?(convertData(todos: model.getTodos()))
    }

    func convertData(todos: [TodoItem]) -> TodosGrouped {
        var sections: TodosGrouped = []
        todos.forEach { todo in
            guard let deadline = todo.deadline else {
                if let existedIndex = sections.firstIndex(where: { $0.0 == "Другое" }) {
                    sections[existedIndex].1.append(todo)
                } else {
                    sections.append(("Другое", [todo]))
                }
                return
            }
            if let existedIndex = sections.firstIndex(where: { $0.0 == deadline.asHumanString(format: Date.calendarFormatCell) }) {
                sections[existedIndex].1.append(todo)
            } else {
                sections.append((deadline.asHumanString(format: Date.calendarFormatCell), [todo]))
            }
        }
        return sections
    }
    
    func setCompleted(todo: TodoItem, isCompleted: Bool) {
        model.setCompleted(todo: todo, isCompleted: isCompleted)
        self.todosBinding?(convertData(todos: model.getTodos()))
    }
}


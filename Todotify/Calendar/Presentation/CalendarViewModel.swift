//
//  CalendarViewModel.swift
//  Todotify
//
//  Created by Murad Azimov on 04.07.2024.
//

import Foundation

typealias CalendarBinding<T> = (T) -> Void
typealias TodosGrouped = [(Date, [TodoItem])]

final class CalendarViewModel {
    var todosBinding: CalendarBinding<TodosGrouped>?

    private let model: CalendarModel

    init(for model: CalendarModel) {
        self.model = model
    }
    
    // чет сложно, надо упростить
    func loadTodos() {
        self.todosBinding?(convertData(todos: model.getTodos()))
    }
    
    func updateTodos(store: Store) {
        self.todosBinding?(convertData(todos: store.todos))
    }

    func convertData(todos: [TodoItem]) -> TodosGrouped {
        var sections: TodosGrouped = []
        todos.forEach { todo in
            let deadline = todo.deadline ?? Date(timeIntervalSince1970: 0)
        
            if let existedIndex = sections.firstIndex { Calendar.current.isDate($0.0, equalTo: deadline, toGranularity: .day) } {
                sections[existedIndex].1.append(todo)
            } else {
                sections.append((deadline, [todo]))
            }
        }
        sections.sort { $0.0 < $1.0 }
        let withoutDate = sections.removeFirst()
        sections.append(withoutDate)
        return sections
    }
    
    func convertTitles(sections: TodosGrouped) -> [String] {
        sections.map {
            let isOtherSection = $0.0 == Date(timeIntervalSince1970: 0)
            return isOtherSection ? "Другое" : $0.0.asHumanString(format: Date.calendarFormatCell)
        }
    }
    
    func setCompleted(todo: TodoItem, isCompleted: Bool) {
        model.setCompleted(todo: todo, isCompleted: isCompleted)
        self.todosBinding?(convertData(todos: model.getTodos()))
    }
}


//
//  CalendarViewWrapper.swift
//  Todotify
//
//  Created by Murad Azimov on 02.07.2024.
//

import SwiftUI

struct CalendarViewWrapper : UIViewControllerRepresentable {
    @Binding var todos: [TodoItem]
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        guard let vc = uiViewController as? CalendarViewController else { return }
        vc.sections = convertData(todos: todos)
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        return CalendarViewController(sections: convertData(todos: todos))
    }
    
    func convertData(todos: [TodoItem]) -> [(String, [TodoItem])] {
        var sections: [(String, [TodoItem])] = []
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
}

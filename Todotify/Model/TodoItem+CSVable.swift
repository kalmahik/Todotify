//
//  TodoItem+Extensions.swift
//  Todotify
//
//  Created by kalmahik on 17.06.2024.
//

import Foundation

extension TodoItem: CSVable {    
    static var csvHeader: String {
        var columns: [String] = []
        columns.append(TodoCodingKeys.id.stringValue)
        columns.append(TodoCodingKeys.text.stringValue)
        columns.append(TodoCodingKeys.importance.stringValue)
        columns.append(TodoCodingKeys.isCompleted.stringValue)
        columns.append(TodoCodingKeys.createdAt.stringValue)
        columns.append(TodoCodingKeys.editedAt.stringValue)
        columns.append(TodoCodingKeys.deadline.stringValue)
        return columns.joined(separator: ",")
    }
    
    static func parse(csv: String) -> TodoItem? {
        let columns = csv.components(separatedBy: ",")
        if columns.count == TodoCodingKeys.allCases.count {
            let id = columns[0]
            let text = columns[1]
            let importanceString = columns[2]
            let isCompleted = columns[3] == "true"
            let createdAt = columns[4]
            let editedAt = columns[5].isEmpty ? nil : columns[5]
            let deadline = columns[6].isEmpty ? nil : columns[6]
            let importance = Importance(rawValue: importanceString) ?? Importance.usual
            
            return TodoItem(
                id: id,
                text: text,
                importance: importance,
                deadline: Date.fromString(date: deadline),
                isCompleted: isCompleted,
                createdAt: Date.fromString(date: createdAt)!,
                editedAt: Date.fromString(date: editedAt)
            )
        } else {
            Logger.shared.warning("THIS IS NOT VALID TODO ITEM")
            return nil
        }
    }
    
    var csv: String {
        var columns: [String] = []
        columns.append(id)
        columns.append(text)
        columns.append(importance.rawValue)
        columns.append("\(isCompleted)")
        columns.append(createdAt.asString())
        columns.append(editedAt?.asString() ?? "")
        columns.append(deadline?.asString() ?? "")
        return columns.joined(separator: ",")
    }
}

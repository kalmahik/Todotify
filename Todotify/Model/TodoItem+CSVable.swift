//
//  TodoItem+Extensions.swift
//  Todotify
//
//  Created by kalmahik on 17.06.2024.
//

import CocoaLumberjackSwift
import Foundation

extension TodoItem: CSVable {
    // регулярка, которая находит все запятые, кроме запятых внутри кавычек
    static let regexFindCommaNotInsideQuotes = #"(?!\B"[^"]*),(?![^"]*"\B)"#

    static var csvHeader: String {
        var columns: [String] = []
        columns.append(TodoCodingKeys.id.rawValue)
        columns.append(TodoCodingKeys.text.rawValue)
        columns.append(TodoCodingKeys.importance.rawValue)
        columns.append(TodoCodingKeys.isCompleted.rawValue)
        columns.append(TodoCodingKeys.createdAt.rawValue)
        columns.append(TodoCodingKeys.editedAt.rawValue)
        columns.append(TodoCodingKeys.deadline.rawValue)
        return columns.joined(separator: ",")
    }

    static func parse(csv: String) -> TodoItem? {
        let columns = String.splitTextByRegex(text: csv, regexPattern: regexFindCommaNotInsideQuotes)

        if columns.count == TodoCodingKeys.allCases.count {
            let id = columns[0]
            let text = columns[1]
            let importanceString = columns[2]
            let isCompleted = columns[3].lowercased() == "true"
            let createdAt = columns[4]
            let editedAt = columns[5].isEmpty ? nil : columns[5]
            let deadline = columns[6].isEmpty ? nil : columns[6]
            let importance = Importance(rawValue: importanceString) ?? .basic

            return TodoItem(
                id: id,
                text: text,
                importance: importance,
                deadline: Date.fromString(deadline),
                isCompleted: isCompleted,
                createdAt: Date.fromString(createdAt) ?? Date(),
                editedAt: Date.fromString(editedAt)
            )
        } else {
            DDLogWarn("THIS IS NOT VALID TODO ITEM")
            return nil
        }
    }

    var csv: String {
        var columns: [String] = []
        columns.append(id)
        columns.append(text.contains(",") ? "\"\(text)\"" : text)
        columns.append(importance.rawValue)
        columns.append("\(isCompleted)")
        columns.append(createdAt.asString())
        columns.append(editedAt?.asString() ?? "")
        columns.append(deadline?.asString() ?? "")
        return columns.joined(separator: ",")
    }
}

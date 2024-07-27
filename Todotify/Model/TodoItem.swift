//
//  TodoItem.swift
//  Todotify
//
//  Created by kalmahik on 17.06.2024.
//

import SwiftData
import SwiftUI

enum Importance: String, Codable {
    case low
    case basic
    case important
}

@Model
final class TodoItem: Identifiable {
    @Attribute(.unique)
    let id: String
    let text: String
    let importance: Importance
    let deadline: Date?
    let isCompleted: Bool
    let createdAt: Date
    let editedAt: Date?
    let hexColor: String
    let category: Category
    let lastUpdatedBy: String

    init(
        id: String? = nil,
        text: String,
        importance: Importance? = nil,
        deadline: Date? = nil,
        isCompleted: Bool? = nil,
        createdAt: Date? = nil,
        editedAt: Date? = nil,
        hexColor: String? = nil,
        category: Category? = nil,
        lastUpdatedBy: String? = nil
    ) {
        self.id = id ?? UUID().uuidString
        self.text = text
        self.importance = importance ?? .basic
        self.deadline = deadline
        self.isCompleted = isCompleted ?? false
        self.createdAt = createdAt ?? Date()
        self.editedAt = editedAt
        self.hexColor = hexColor ?? Color.clear.toHex()
        self.category = category ?? Category.defaultCategory
        self.lastUpdatedBy = "deviceID"
    }

    init(from: TodoItemDTO) {
        self.id = from.id
        self.text = from.text
        self.importance = from.importance
        self.deadline = from.deadline != nil ? Date(timeIntervalSince1970: Double(from.deadline!)) : nil
        self.isCompleted = from.done
        self.createdAt = Date(timeIntervalSince1970: Double(from.createdAt))
        self.editedAt = Date(timeIntervalSince1970: Double(from.changedAt))
        self.hexColor = from.color ?? Color.clear.toHex()
        self.category = Category.defaultCategory
        self.lastUpdatedBy = from.lastUpdatedBy
    }

    func copy(
        id: String? = nil,
        text: String? = nil,
        importance: Importance? = nil,
        deadline: Date? = nil,
        isCompleted: Bool? = nil,
        createdAt: Date? = nil,
        editedAt: Date? = nil,
        hexColor: String? = nil,
        category: Category? = nil,
        lastUpdatedBy: String? = nil
    ) -> TodoItem {
        return TodoItem(
            id: id ?? self.id,
            text: text ?? self.text,
            importance: importance ?? self.importance,
            deadline: deadline ?? self.deadline,
            isCompleted: isCompleted ?? self.isCompleted,
            createdAt: createdAt ?? self.createdAt,
            editedAt: editedAt ?? self.editedAt,
            hexColor: hexColor ?? self.hexColor,
            category: category ?? self.category,
            lastUpdatedBy: lastUpdatedBy ?? self.lastUpdatedBy
        )
    }
}

enum TodoCodingKeys: String, CaseIterable {
    case id = "id"
    case text = "text"
    case importance = "importance"
    case isCompleted = "isCompleted"
    case createdAt = "createdAt"
    case deadline = "deadline"
    case editedAt = "editedAt"
}

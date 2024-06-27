//
//  TodoItem.swift
//  Todotify
//
//  Created by kalmahik on 17.06.2024.
//

import Foundation

enum Importance: String {
    case unimportant
    case usual
    case important
}

struct TodoItem: Identifiable {
    let id: String
    let text: String
    let importance: Importance
    let deadline: Date?
    let isCompleted: Bool
    let createdAt: Date
    let editedAt: Date?
    
    init(
        id: String? = nil,
        text: String,
        importance: Importance? = nil,
        deadline: Date? = nil,
        isCompleted: Bool? = nil,
        createdAt: Date? = nil,
        editedAt: Date? = nil
    ) {
        self.id = id ?? UUID().uuidString
        self.text = text
        self.importance = importance ?? .important
        self.deadline = deadline
        self.isCompleted = isCompleted ?? false
        self.createdAt = createdAt ?? Date()
        self.editedAt = editedAt
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

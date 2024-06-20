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

struct TodoItem {
    let id: String
    let text: String
    let importance: Importance
    let deadline: Date?
    let isCompleted: Bool
    let createdAt: Date
    let editedAt: Date?
    
    init(
        id: String = UUID().uuidString,
        text: String,
        importance: Importance = .usual,
        deadline: Date? = nil,
        isCompleted: Bool = false,
        createdAt: Date = Date(),
        editedAt: Date? = nil
    ) {
        self.id = id
        self.text = text
        self.importance = importance
        self.deadline = deadline
        self.isCompleted = isCompleted
        self.createdAt = createdAt
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

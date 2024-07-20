//
//  TodoItemDTO.swift
//  Todotify
//
//  Created by Murad Azimov on 17.07.2024.
//

import Foundation
import UIKit

struct TodoItemDTO: Codable {
    let id: String
    let text: String
    let importance: Importance
    let deadline: Int64?
    let done: Bool
    let color: String?
    let createdAt: Int64
    let changedAt: Int64
    let lastUpdatedBy: String

    init(from: TodoItem) {
        self.id = from.id
        self.text = from.text
        self.importance = from.importance
        self.deadline = from.deadline != nil ? Int64(from.deadline!.timeIntervalSince1970) : nil
        self.done = from.isCompleted
        self.createdAt = Int64(from.createdAt.timeIntervalSince1970)
        self.changedAt = Int64((from.editedAt ?? from.createdAt).timeIntervalSince1970)
        self.color = from.hexColor
        self.lastUpdatedBy = "deviceID"
    }
}

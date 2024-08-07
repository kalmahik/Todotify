//
//  TodoItem+Extensions.swift
//  Todotify
//
//  Created by kalmahik on 17.06.2024.
//

import CocoaLumberjackSwift
import Foundation

extension TodoItem: JSONable {
    static func parse(json: Any) -> TodoItem? {
        if let jsonData = json as? Data {
            return parse(jsonData: jsonData)
        }
        if let jsonDictionary = json as? JSONDictionary {
            return parse(jsonDictionary: jsonDictionary)
        }
        return nil
    }

    static func parse(jsonData: Data) -> TodoItem? {
        do {
            if let jsonObject = try JSONSerialization.jsonObject(with: jsonData) as? JSONDictionary {
                return parse(jsonDictionary: jsonObject)
            }
            DDLogWarn("THIS IS NOT JSON")
            return nil
        } catch let error as NSError {
            DDLogWarn("\(error.localizedDescription)")
            return nil
        }
    }

    static func parse(jsonDictionary: JSONDictionary) -> TodoItem? {
        let id = jsonDictionary[TodoCodingKeys.id.rawValue] as? String ?? UUID().uuidString
        let text = jsonDictionary[TodoCodingKeys.text.rawValue] as? String
        let isCompleted = jsonDictionary[TodoCodingKeys.isCompleted.rawValue] as? Bool ?? false
        let createdAt = jsonDictionary[TodoCodingKeys.createdAt.rawValue] as? String
        let deadline = jsonDictionary[TodoCodingKeys.deadline.rawValue] as? String
        let editedAt = jsonDictionary[TodoCodingKeys.editedAt.rawValue] as? String
        let importanceString = jsonDictionary[TodoCodingKeys.importance.rawValue] as? String ?? Importance.basic.rawValue
        let importance = Importance(rawValue: importanceString) ?? .basic

        guard let text else {
            DDLogWarn("THIS IS NOT VALID TODO ITEM")
            return nil
        }

        return TodoItem(
            id: id,
            text: text,
            importance: importance,
            deadline: Date.fromString(deadline),
            isCompleted: isCompleted,
            createdAt: Date.fromString(createdAt) ?? Date(),
            editedAt: Date.fromString(editedAt)
        )
    }

    var json: Any {
        var dictionary: JSONDictionary = [:]
        dictionary[TodoCodingKeys.id.rawValue] = id
        dictionary[TodoCodingKeys.text.rawValue] = text
        dictionary[TodoCodingKeys.isCompleted.rawValue] = isCompleted
        dictionary[TodoCodingKeys.createdAt.rawValue] = createdAt.asString()
        if importance != .basic {
            dictionary[TodoCodingKeys.importance.rawValue] = importance.rawValue
        }
        if let deadline {
            dictionary[TodoCodingKeys.deadline.rawValue] = deadline.asString()
        }
        if let editedAt {
            dictionary[TodoCodingKeys.editedAt.rawValue] = editedAt.asString()
        }
        return dictionary
    }
}

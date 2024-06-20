//
//  TodoItem+Extensions.swift
//  Todotify
//
//  Created by kalmahik on 17.06.2024.
//

import Foundation

extension TodoItem: JSONable {
    static func parse(json: Any) -> TodoItem? {
        if let jsonData = json as? Data {
            return parse(jsonData: jsonData)
        }
        if let jsonDictionary = json as? JsonDictionary {
            return parse(jsonDictionary: jsonDictionary)
        }
        return nil
    }
    
    static func parse(jsonData: Data) -> TodoItem? {
        do {
            if let jsonObject = try JSONSerialization.jsonObject(with: jsonData) as? JsonDictionary {
                return parse(jsonDictionary: jsonObject)
            }
            Logger.shared.warning("THIS IS NOT TODO ITEM")
            return nil
        } catch let error as NSError {
            Logger.shared.error(error.localizedDescription)
            return nil
        }
    }
    
    static func parse(jsonDictionary: JsonDictionary) -> TodoItem? {
        let id = jsonDictionary[TodoCodingKeys.id.stringValue] as? String
        let text = jsonDictionary[TodoCodingKeys.text.stringValue] as? String
        let isCompleted = jsonDictionary[TodoCodingKeys.isCompleted.stringValue] as? Bool
        let createdAt = jsonDictionary[TodoCodingKeys.createdAt.stringValue] as? String
        let deadline = jsonDictionary[TodoCodingKeys.deadline.stringValue] as? String
        let editedAt = jsonDictionary[TodoCodingKeys.editedAt.stringValue] as? String
        let importanceString = jsonDictionary[TodoCodingKeys.importance.stringValue] as? String ?? Importance.usual.rawValue
        let importance = Importance(rawValue: importanceString) ?? Importance.usual
        
        guard let id, let text, let isCompleted, let createdAt else {
            Logger.shared.warning("THIS IS NOT VALID TODO ITEM")
            return nil
        }

        return TodoItem(
            id: id,
            text: text,
            importance: importance,
            deadline: Date.fromString(date: deadline),
            isCompleted: isCompleted,
            createdAt: Date.fromString(date: createdAt)!,
            editedAt: Date.fromString(date: editedAt)
        )
    }
    
    var json: Any {
        var dictionary: JsonDictionary = [:]
        dictionary[TodoCodingKeys.id.stringValue] = id
        dictionary[TodoCodingKeys.text.stringValue] = text
        dictionary[TodoCodingKeys.isCompleted.stringValue] = isCompleted
        dictionary[TodoCodingKeys.createdAt.stringValue] = createdAt.asString()
        if importance != .usual {
            dictionary[TodoCodingKeys.importance.stringValue] = importance.rawValue
        }
        if let deadline {
            dictionary[TodoCodingKeys.deadline.stringValue] = deadline.asString()
        }
        if let editedAt {
            dictionary[TodoCodingKeys.editedAt.stringValue] = editedAt.asString()
        }
        return dictionary
    }
}

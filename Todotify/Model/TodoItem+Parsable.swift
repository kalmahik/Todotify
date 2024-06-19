//
//  TodoItem+Extensions.swift
//  Todotify
//
//  Created by kalmahik on 17.06.2024.
//

import Foundation

typealias JsonDictionary = [String: Any]

extension TodoItem: Parsable {
    private enum CodingKeys: CodingKey {
          case id, text, isCompleted, createdAt, deadline, editedAt, importance
    }
    
    static func parse(json: Any) -> TodoItem? {
        do {
            if let jsonObject = try JSONSerialization.jsonObject(with: json as! Data, options: []) as? JsonDictionary {
                let id = jsonObject[CodingKeys.id.stringValue] as? String
                let text = jsonObject[CodingKeys.text.stringValue] as? String
                let isCompleted = jsonObject[CodingKeys.isCompleted.stringValue] as? Bool
                let createdAt = jsonObject[CodingKeys.createdAt.stringValue] as? String
                let deadline = jsonObject[CodingKeys.deadline.stringValue] as? String
                let editedAt = jsonObject[CodingKeys.editedAt.stringValue] as? String
                let importanceString = jsonObject[CodingKeys.importance.stringValue] as? String ?? Importance.usual.rawValue
                let importance = Importance(rawValue: importanceString) ?? Importance.usual
                
                guard let id, let text, let isCompleted, let createdAt else {
                    print("IS NOT VALID TODO ITEM")
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
            print("THIS IS NOT TODO ITEM")
            return nil
        } catch let error as NSError {
            print("SMTH WENT GRONG: \(error.localizedDescription)")
            return nil
        }
    }
    
    var json: Any {
        var dictionary: JsonDictionary = [:]
        dictionary[CodingKeys.id.stringValue] = id
        dictionary[CodingKeys.text.stringValue] = text
        dictionary[CodingKeys.isCompleted.stringValue] = isCompleted
        dictionary[CodingKeys.createdAt.stringValue] = createdAt.asString()
        if importance != .usual {
            dictionary[CodingKeys.importance.stringValue] = importance.rawValue
        }
        if let deadline {
            dictionary[CodingKeys.deadline.stringValue] = deadline.asString()
        }
        if let editedAt {
            dictionary[CodingKeys.editedAt.stringValue] = editedAt.asString()
        }
        return dictionary
    }
}

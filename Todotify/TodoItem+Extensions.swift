//
//  TodoItem+Extensions.swift
//  Todotify
//
//  Created by kalmahik on 17.06.2024.
//

import Foundation

typealias JsonDictionary = [String: Any]

extension TodoItem {
    static func parse(json: Any) -> TodoItem? {
//        guard JSONSerialization.isValidJSONObject(json) else {
//            print("IS NOT VALID JSON OBJECT")
//            return nil
//        }
        do {
            if let jsonObject = try JSONSerialization.jsonObject(with: json as! Data, options: []) as? JsonDictionary {
                let id = jsonObject["id"] as? String
                let text = jsonObject["text"] as? String
                let isCompleted = jsonObject["isCompleted"] as? Bool
                let createdAt = jsonObject["createdAt"] as? String
                let deadline = jsonObject["deadline"] as? String
                let editedAt = jsonObject["editedAt"] as? String
                let importanceString = jsonObject["importance"] as? String ?? Importance.usual.rawValue
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
            print("Failed to load: \(error.localizedDescription)")
            return nil
        }
    }
    
    var json: Any {
        var dictionary: JsonDictionary = [:]
        dictionary["id"] = id as NSString
        dictionary["text"] = text as NSString
        dictionary["isCompleted"] = isCompleted
        dictionary["createdAt"] = createdAt.asString() as NSString
        if importance != .usual {
            dictionary["importance"] = importance.rawValue
        }
        if let deadline {
            dictionary["deadline"] = deadline.asString()
        }
        if let editedAt {
            dictionary["editedAt"] = editedAt.asString()
        }
        if let data = try? JSONSerialization.data(withJSONObject: dictionary) {
            return data
        }
        return Data()
    }
}

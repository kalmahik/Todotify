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
        guard JSONSerialization.isValidJSONObject(json) else {
            print("IS NOT VALID JSON OBJECT")
            return nil
        }
        do {
            if let jsonObject = try JSONSerialization.jsonObject(with: json as! Data, options: []) as? JsonDictionary {
                let id = jsonObject["id"] as? String
                let text = jsonObject["text"] as? String
                let isCompleted = jsonObject["isCompleted"] as? Bool
                let createdAt = jsonObject["createdAt"] as? Date
                let deadline = jsonObject["deadline"] as? Date
                let editedAt = jsonObject["editedAt"] as? Date
                let importance = jsonObject["importance"] as? Importance ?? .usual
                
                guard let id, let text, let isCompleted, let createdAt else {
                    print("IS NOT VALID TODO ITEM")
                    return nil
                }

                return TodoItem(
                    id: id,
                    text: text,
                    importance: importance,
                    deadline: deadline,
                    isCompleted: isCompleted,
                    createdAt: createdAt,
                    editedAt: editedAt
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
        dictionary["id"] = id
        dictionary["text"] = text
        dictionary["isCompleted"] = isCompleted
        dictionary["createdAt"] = createdAt
        if importance != .usual {
            dictionary["importance"] = importance
        }
        if let deadline {
            dictionary["deadline"] = deadline
        }
        if let editedAt {
            dictionary["editedAt"] = editedAt
        }
        if let data = try? JSONSerialization.data(withJSONObject: dictionary) {
            return data
        }
        return Data()
    }
}

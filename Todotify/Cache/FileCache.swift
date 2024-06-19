//
//  FileCache.swift
//  Todotify
//
//  Created by kalmahik on 18.06.2024.
//

import Foundation

final class FileCache: Cacheable {
    
    private(set) var todos: [TodoItem] = []
    
    func add(todo: TodoItem) {
        let existedIndex = todos.firstIndex { $0.id == todo.id } ?? -1
        if existedIndex >= 0 {
            Logger.shared.info("ITEM EXIST, EDITING")
        } else {
            todos.append(todo)
        }
    }
    
    func removeTodo(by id: String) {
        todos.removeAll { $0.id == id }
    }
    
    func saveToFile(fileName: String) {
        let todosJson = todos.map { $0.json }
        do {
            guard let filename = FileManager.getFile(name: fileName) else {
                Logger.shared.warning("FILE NOT FOUND")
                return
            }
            let isNotValidJson = !JSONSerialization.isValidJSONObject(todosJson)
            if isNotValidJson {
                Logger.shared.warning("NOT VALID JSON OBJECT")
                return
            }
            let data = try JSONSerialization.data(withJSONObject: todosJson)
            try data.write(to: filename)
        } catch let error as NSError {
            Logger.shared.error(error.localizedDescription)
        }
    }

    
    func readFromFile(fileName: String) -> [TodoItem] {
        do {
            guard let filename = FileManager.getFile(name: fileName) else {
                Logger.shared.warning("NOT VALID JSON OBJECT")
                return []
            }
            let data = try Data(contentsOf: filename)
            let todosJson = try JSONSerialization.jsonObject(with: data) as? [JsonDictionary] ?? []
            return todosJson.compactMap { TodoItem.parse(json: $0) }
        } catch let error as NSError {
            Logger.shared.error(error.localizedDescription)
            return []
        }
    }
}

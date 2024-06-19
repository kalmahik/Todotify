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
            todos[existedIndex] = todo
        } else {
            todos.append(todo)
        }
    }
    
    func removeTodo(by id: String) {
        todos.removeAll { $0.id == id }
    }
    
    func saveToFile(fileName: String) throws {
        let todosJson = todos.map { $0.json }
        do {
            guard let filename = FileManager.getFile(name: fileName) else {
                throw FileManagerError.fileNotFound
            }
            let isFileExist = FileManager.isFileExist(name: fileName)
            if isFileExist {
                Logger.shared.info("ITEM EXIST, REPLACE")
            }
            let isNotValidJson = !JSONSerialization.isValidJSONObject(todosJson)
            if isNotValidJson {
                throw JsonError.notValidJsonObject
            }
            let data = try JSONSerialization.data(withJSONObject: todosJson)
            try data.write(to: filename)
        } catch let error as NSError {
            throw JsonError.error(error.localizedDescription)
        }
    }

    
    func readFromFile(fileName: String) throws -> [TodoItem] {
        do {
            guard let filename = FileManager.getFile(name: fileName) else {
                throw FileManagerError.fileNotFound
            }
            let data = try Data(contentsOf: filename)
            let todosJson = try JSONSerialization.jsonObject(with: data) as? [JsonDictionary] ?? []
            return todosJson.compactMap { TodoItem.parse(json: $0) }
        } catch let error as NSError {
            throw JsonError.error(error.localizedDescription)
        }
    }
}

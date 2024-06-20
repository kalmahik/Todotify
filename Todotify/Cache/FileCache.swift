//
//  FileCache.swift
//  Todotify
//
//  Created by kalmahik on 18.06.2024.
//

import Foundation

enum Format {
    case json
    case csv
}

final class FileCache: Cacheable {
    
    private(set) var todos: [TodoItem] = []
    
    func add(todo: TodoItem) {
        let existedIndex = todos.firstIndex { $0.id == todo.id } ?? -1
        if existedIndex >= 0 {
            Logger.shared.info("TODO EXIST, REPLACING")
            todos[existedIndex] = todo
        } else {
            todos.append(todo)
        }
    }
    
    func removeTodo(by id: String) {
        todos.removeAll { $0.id == id }
    }
    
    func saveToFile(fileName: String, format: Format = .json) throws {
        do {
            guard let filename = FileManager.getFile(name: fileName) else {
                throw FileManagerError.fileNotFound
            }
            let isFileExist = FileManager.isFileExist(name: fileName)
            if isFileExist {
                Logger.shared.info("FILE EXIST, REPLACING")
            }
            switch format {
            case .json:
                let todosJSON = todos.map { $0.json }
                let isNotValidJson = !JSONSerialization.isValidJSONObject(todosJSON)
                if isNotValidJson {
                    throw JsonError.notValidJsonObject
                }
                let data = try JSONSerialization.data(withJSONObject: todosJSON)
                try data.write(to: filename)
            case .csv:
                let CSVString = ([TodoItem.csvHeader] + todos.map { $0.csv }).joined(separator: "\n")
                try CSVString.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
            }
        } catch let error as NSError {
            throw JsonError.error(error.localizedDescription)
        }
    }

    
    func readFromFile(fileName: String, format: Format = .json) throws -> [TodoItem] {
        do {
            guard let filename = FileManager.getFile(name: fileName) else {
                throw FileManagerError.fileNotFound
            }
            let isFileExist = FileManager.isFileExist(name: fileName)
            if !isFileExist {
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

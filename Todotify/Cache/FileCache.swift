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
        if let existedIndex = todos.firstIndex(where: { $0.id == todo.id }) {
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
            // что-то мне кажется, что лучше это вынести из этого класса...
            switch format {
            case .json:
                let todosJSON = todos.map { $0.json }
                let isNotValidJson = !JSONSerialization.isValidJSONObject(todosJSON)
                if isNotValidJson {
                    throw JSONError.notValidJSONObject
                }
                let data = try JSONSerialization.data(withJSONObject: todosJSON)
                try data.write(to: filename)
            case .csv:
                let CSVString = ([TodoItem.csvHeader] + todos.map { $0.csv }).joined(separator: "\n")
                try CSVString.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
            }
        } catch let error {
            throw JSONError.error(error.localizedDescription)
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
            // что-то мне кажется, что лучше это вынести из этого класса...
            switch format {
            case .json:
                let data = try Data(contentsOf: filename)
                let todosJson = try JSONSerialization.jsonObject(with: data) as? [JSONDictionary] ?? []
                return todosJson.compactMap { TodoItem.parse(json: $0) }
            case .csv:
                let data = try String(contentsOf: filename)
                var rows = data.components(separatedBy: "\n")
                rows.removeFirst()
                return rows.compactMap { TodoItem.parse(csv: $0) }
            }
        } catch let error {
            switch format {
            case .json: throw JSONError.error(error.localizedDescription)
            case.csv: throw CSVError.error(error.localizedDescription)
            }
        }
    }
}

//
//  FileCache.swift
//  Todotify
//
//  Created by kalmahik on 18.06.2024.
//

import Foundation

final class FileCache {
    private(set) var todos: [TodoItem] = []
    
    func add(todo: TodoItem) {
        let existedIndex = todos.firstIndex { $0.id == todo.id } ?? -1
        if existedIndex >= 0 {
            print("ITEM EXIST, EDITING?")
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
            guard let filename = getDocument(by: fileName) else {
                print("FILE NOT FOUND")
                return
            }
            let data = try JSONSerialization.data(withJSONObject: todosJson)
            try data.write(to: filename)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }

    
    func readFromFile(fileName: String) -> [TodoItem] {
        do {
            guard let filename = getDocument(by: "output.txt") else {
                print("FILE NOT FOUND")
                return []
            }
            let data = try Data(contentsOf: filename)
            if let todosJson = try JSONSerialization.jsonObject(with: data, options: []) as? [JsonDictionary] {
                return try todosJson.compactMap {
                    let jsonData = try JSONSerialization.data(withJSONObject: $0)
                    return TodoItem.parse(json: jsonData)
                }
            }
        } catch let error as NSError {
            print(error.localizedDescription)
            return []
        }
        return []
    }

    
    private func getDocument(by name: String) -> URL? {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        return paths?.appendingPathComponent(name)
    }
}

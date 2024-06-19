//
//  Cacheable.swift
//  Todotify
//
//  Created by kalmahik on 19.06.2024.
//

import Foundation

protocol Cacheable {
    var todos: [TodoItem] { get }
    
    func add(todo: TodoItem)
    func removeTodo(by id: String)
    func saveToFile(fileName: String)
    func readFromFile(fileName: String) -> [TodoItem]
}
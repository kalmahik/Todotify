//
//  NetworkService.swift
//  Todotify
//
//  Created by Murad Azimov on 17.07.2024.
//

import Foundation

protocol NetworkService: ObservableObject {
    func fetchListOfTodos() async -> [TodoItem]
    func fetchCreateTodo(todo: TodoItem) async -> TodoItem?
    func fetchTodo(todoId: String) async -> TodoItem?
}

//
//  NetworkService.swift
//  Todotify
//
//  Created by Murad Azimov on 17.07.2024.
//

import Foundation

protocol NetworkService: ObservableObject {
    func fetchTodos() async -> [TodoItem]
    func fetchTodo(todoId: String) async -> TodoItem?
    func fetchCreateTodo(todo: TodoItem) async -> TodoItem?
    func fetchEditTodo(todo: TodoItem) async -> TodoItem?
    func fetchDeleteTodo(todo: TodoItem) async -> TodoItem?
}

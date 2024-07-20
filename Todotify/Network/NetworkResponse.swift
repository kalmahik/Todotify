//
//  NetworkResponse.swift
//  Todotify
//
//  Created by Murad Azimov on 19.07.2024.
//

import Foundation

protocol Response: Decodable {
    var revision: Int { get }
}

struct ListResponse: Response {
    let status: String
    let list: [TodoItemDTO]
    let revision: Int
}

struct ElementResponse: Response {
    let status: String
    let element: TodoItemDTO
    let revision: Int
}

struct ElementRequest: Codable {
    let element: TodoItemDTO
}

struct ListRequest: Codable {
    let list: [TodoItemDTO]
}

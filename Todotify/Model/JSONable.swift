//
//  Parsable.swift
//  Todotify
//
//  Created by kalmahik on 19.06.2024.
//

import Foundation

enum JsonError: Error {
    case notValidJsonObject
    case notValidTodoItem
    case error(String)
}

typealias JsonDictionary = [String: Any]

protocol Parsable {
    static func parse(json: Any) -> Self?
    var json: Any { get }
}

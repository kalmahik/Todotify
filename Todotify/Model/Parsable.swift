//
//  Parsable.swift
//  Todotify
//
//  Created by kalmahik on 19.06.2024.
//

import Foundation

protocol Parsable {
    static func parse(json: Any) -> Self?
    var json: Any { get }
}

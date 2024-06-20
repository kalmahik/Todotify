//
//  CSVable.swift
//  Todotify
//
//  Created by kalmahik on 19.06.2024.
//

import Foundation

protocol CSVable {
    static var csvHeader: String { get }
    static func parse(csv: String) -> Self?
    var csv: String { get }
}

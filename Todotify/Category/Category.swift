//
//  Category.swift
//  Todotify
//
//  Created by Murad Azimov on 05.07.2024.
//

import Foundation

struct Category: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let hexColor: String
}

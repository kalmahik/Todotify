//
//  Category.swift
//  Todotify
//
//  Created by Murad Azimov on 05.07.2024.
//

import SwiftUI

struct Category: Identifiable, Equatable, Codable {
    static let defaultCategory = Category(name: "Другое", hexColor: Color.clear.toHex())

    var id = UUID()
    let name: String
    let hexColor: String
}

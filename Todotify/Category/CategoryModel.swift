//
//  CategoryModel.swift
//  Todotify
//
//  Created by kalmahik on 07.05.2024.

import SwiftUI

final class CategoryModel: ObservableObject {
    @Published var categories: [Category] = [
        Category(name: "Work", hexColor: Color.red.toHex()),
        Category(name: "Personal", hexColor: Color.green.toHex()),
        Category(name: "Shopping", hexColor: Color.blue.toHex()),
        Category(name: "Fitness", hexColor: Color.yellow.toHex())
    ]

    func add(category: Category) {
        categories.append(category)
    }
}

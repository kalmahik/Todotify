//
//  CategoryModel.swift
//  Todotify
//
//  Created by kalmahik on 07.05.2024.

import SwiftUI

final class CategoryModel: ObservableObject {
    @Published var categories: [Category] = [
        Category(name: "Work", hexColor: Color.red.toHexString()),
        Category(name: "Personal", hexColor: Color.green.toHexString()),
        Category(name: "Shopping", hexColor: Color.blue.toHexString()),
        Category(name: "Fitness", hexColor: Color.yellow.toHexString())
    ]

    func add(category: Category) {
        categories.append(category)
    }
}

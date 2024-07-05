//
//  CategoryPicker.swift
//  Todotify
//
//  Created by Murad Azimov on 05.07.2024.
//

import SwiftUI

struct CategoryPicker: View {
    @Binding var selectedCategory: Category
    var categories: [Category]
    
    var body: some View {
        VStack {
            ForEach(categories) { category in
                HStack {
                    Text(category.name)
                    Spacer()
                    CategoryView(category: category)
                        .overlay(
                            Circle()
                                .stroke(selectedCategory.name == category.name ? .black : .clear, lineWidth: 2)
                        )
                }
                .onTapGesture {
                    selectedCategory = category
                }
            }
        }
    }
}

struct CategoryView: View {
    let category: Category
    
    var body: some View {
        Circle()
            .fill(Color(hex: category.hexColor) ?? .clear)
            .frame(width: 24, height: 24)
            .overlay(
                Circle()
                    .stroke(Color.white, lineWidth: 2)
            )
    }
}

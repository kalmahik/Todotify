//
//  CategoryPicker.swift
//  Todotify
//
//  Created by Murad Azimov on 05.07.2024.
//

import SwiftUI

struct CategoryPicker: View {
    @Binding var selectedCategory: Category?
    var categories: [Category]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(categories) { category in
                    CategoryView(category: category)
                        .onTapGesture {
                            selectedCategory = category
                        }
                        .overlay(
                            Circle()
                                .stroke(selectedCategory == category ? .black : .clear, lineWidth: 2)
                        )
                        .padding(4)
                }
            }
        }
    }
}

struct CategoryView: View {
    let category: Category

    var body: some View {
        Circle()
            .fill(Color(hex: category.hexColor))
            .frame(width: 24, height: 24)
            .overlay(
                Circle()
                    .stroke(Color.white, lineWidth: 2)
            )
    }
}


//#Preview {
//    @State var selectedCategory = Category(name: "123", hexColor: "#FF00FF")
//    return CategoryPicker(selectedCategory: $selectedCategory, categories: [])
//}

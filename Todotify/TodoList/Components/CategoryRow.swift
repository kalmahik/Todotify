//
//  TodoRow.swift
//  Todotify
//
//  Created by kalmahik on 17.06.2024.
//

import SwiftUI

struct CategoryRow: View {
    var category: Category
    
    var body: some View {
        HStack {
            Text(category.name)
            Spacer()
            CategoryView(category: category)
        }
        
    }
}

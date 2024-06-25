//
//  TodoRow.swift
//  Todotify
//
//  Created by kalmahik on 17.06.2024.
//

import SwiftUI

struct TodoRow: View {
    var todo: TodoItem

    var body: some View {
        HStack {
            Text(todo.text)
            Spacer()
        }
    }
}

//#Preview {
//    Group {
//        NoteRow(todo: viewModel.todos[0])
//    }
//}

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
        let isCompleted = todo.isCompleted
        let isImportant = todo.importance == .important
        let isUnimportant = todo.importance == .unimportant
        HStack {
            Image(isCompleted ? "checkOn" : isImportant ? "checkAlert" : "checkOff")
            
            Image(isImportant ? "importanceImportant" : isUnimportant ? "importanceUnimportant" : "")
            
            VStack(alignment: .leading) {
                Text(todo.text)
                    .strikethrough(todo.isCompleted)
                    .lineLimit(3)
                
                if let deadline = todo.deadline {
                    HStack {
                        Image(systemName: "calendar")
                        Text(deadline, style: .date)
                            .font(.system(size: 15))
                    }
                    .foregroundColor(.gray)
                }
            }
            .padding(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
            
            Spacer()
            
            Image("chevron")
                .foregroundColor(.red)
            
            Rectangle()
                .fill(Color(hex: todo.hexColor))
                .frame(width: 5)
        }
        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 0))

    }
}

#Preview {
    Group {
        TodoRow(
            todo: TodoItem(
                text: "123123123123123",
                importance: .important,
                deadline: Date(),
                isCompleted: true
            )
        )
    }
}

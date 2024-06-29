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
            Image(isCompleted ? "checkOn" : "checkOff")
            
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
            
            Spacer()
            
            Rectangle()
                .fill(Color(hex: todo.hexColor))
                .frame(width: 5)
            
            Image(systemName: "chevron.right")
        }
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

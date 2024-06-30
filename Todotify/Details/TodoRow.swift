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
        HStack() {
            Button {
                
            } label: {
                Image(systemName: isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(isCompleted ? .green : isImportant ? .red : .gray)
                    .background(!isCompleted && isImportant ? .red.opacity(0.1) : .clear)
                    .clipShape(Circle())
            }
        
            VStack(alignment: .leading) {
                HStack {
                    if !isCompleted && (isImportant || isUnimportant) {
                        Image(isImportant ? "custom.exclamationmark.2" : isUnimportant ? "custom.arrow.down" : "")
                            .padding(EdgeInsets())
                    }
                    
                    Text(todo.text)
                        .strikethrough(todo.isCompleted)
                        .lineLimit(3)
                }
                
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
    TodoList()
}

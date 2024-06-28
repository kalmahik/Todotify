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
                .border(Color.black)
            
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
            
            Image(systemName: "chevron.right")
        }
    }
}

#Preview {
    Group {
        TodoRow(
            todo: TodoItem(
                text: "123123123123123rkjfwlerkjfw lkerjflwkjerhf lkwjer hflkwjher flkwjher flkjwher flkwjher flkwjehrf lkwjhr flkwjehrf lkwjehr fkljwher flkjwher flkjwhe rlkfjehwrlkfjhwelr kjf hwelkrjfh wlkjerh flwjker",
                importance: .important,
                deadline: Date(),
                isCompleted: true
            )
        )
    }
}

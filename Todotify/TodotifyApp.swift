//
//  TodotifyApp.swift
//  Todotify
//
//  Created by kalmahik on 17.06.2024.
//

import SwiftUI

@main
struct TodotifyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    init() {
        let todoItem = TodoItem(
            text: "Позвонить бабушке",
            importance: .important,
            deadline: Date().addingTimeInterval(TimeInterval(3600)),
            isCompleted: false,
            createdAt: Date()
        )
        let json = todoItem.json
        
        let todoItemRestored = TodoItem.parse(json: json)
        
        print(todoItem)
        print(json)
        print(todoItemRestored ?? "")
        
    }
}

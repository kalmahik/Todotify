//
//  TodotifyApp.swift
//  Todotify
//
//  Created by kalmahik on 17.06.2024.
//

import SwiftUI

@main
struct TodotifyApp: App {
    var fileCache = FileCache()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    init() {
        let todoItem1 = TodoItem(
            text: "Позвонить бабушке",
            importance: .important,
            deadline: Date().addingTimeInterval(TimeInterval(3600)),
            isCompleted: false,
            createdAt: Date()
        )
        
        let todoItem2 = TodoItem(
            text: "Купить цветы",
            importance: .important,
            deadline: Date().addingTimeInterval(TimeInterval(3600)),
            isCompleted: false,
            createdAt: Date()
        )
        
        let todoItem3 = TodoItem(
            text: "Взять спортивную форму",
            importance: .important,
            deadline: Date().addingTimeInterval(TimeInterval(3600)),
            isCompleted: false,
            createdAt: Date()
        )
        
        let todoItem4 = TodoItem(
            text: "Оплатить абонемент",
            importance: .important,
            deadline: Date().addingTimeInterval(TimeInterval(3600)),
            isCompleted: false,
            createdAt: Date()
        )
        
        fileCache.add(todo: todoItem1)
        fileCache.add(todo: todoItem2)
        fileCache.add(todo: todoItem3)
        fileCache.add(todo: todoItem4)
        
        fileCache.saveToFile(fileName: "output.txt")
        fileCache.readFromFile(fileName: "output.txt")
    }
}

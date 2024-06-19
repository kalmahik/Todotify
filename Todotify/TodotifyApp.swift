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
        let todoItem1 = TodoItem(text: "Позвонить бабушке")
        let todoItem2 = TodoItem(text: "Купить цветы")
        let todoItem3 = TodoItem(text: "Взять спортивную форму")
        let todoItem4 = TodoItem(text: "Оплатить абонемент")
        
        fileCache.add(todo: todoItem1)
        fileCache.add(todo: todoItem2)
        fileCache.add(todo: todoItem3)
        fileCache.add(todo: todoItem4)
        
        try? fileCache.saveToFile(fileName: "output.txt")
        let data = try? fileCache.readFromFile(fileName: "output.txt")
        print(type(of: data))
        print(data)
    }
}

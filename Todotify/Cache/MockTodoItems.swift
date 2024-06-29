//
//  MockTodoItems.swift
//  Todotify
//
//  Created by Murad Azimov on 28.06.2024.
//

import Foundation

struct MockTodoItems {
    static let items = [
        TodoItem(text: "Тест айтема в одну строку", hexColor: "#FFFFFF"),
        TodoItem(text: "Тест айтема в \n 2 строки", hexColor: "#FF0000"),
        TodoItem(text: "Тест айтема в \n 3 строки \n и более \n тут типа должно обрезаться", hexColor: "#FFFF00"),
        TodoItem(text: "Низкий приоритет", importance: .unimportant, hexColor: "#FF00FF"),
        TodoItem(text: "Высокий приоритет", importance: .important, hexColor: "#FF00FF"),
        TodoItem(text: "Выполненный айтем", isCompleted: true, hexColor: "#00FF00"),
        TodoItem(text: "Айтем с дедлайном", deadline: Date(), hexColor: "#0000FF"),

    ]
}

//
//  MockTodoItems.swift
//  Todotify
//
//  Created by Murad Azimov on 28.06.2024.
//

import Foundation

struct MockTodoItems {
    static let items = [
        TodoItem(text: "Тест айтема в одну строку"),
        TodoItem(text: "Тест айтема в \n 2 строки"),
        TodoItem(text: "Тест айтема в \n 3 строки \n и более \n тут типа должно обрезаться"),
        TodoItem(text: "Низкий приоритет", importance: .unimportant),
        TodoItem(text: "Высокий приоритет", importance: .important),
        TodoItem(text: "Выполненный айтем", isCompleted: true),
        TodoItem(text: "Айтем с дедлайном", deadline: Date()),

    ]
}

//
//  MockTodoItems.swift
//  Todotify
//
//  Created by Murad Azimov on 28.06.2024.
//

import Foundation

struct MockTodoItems {
    static let items = [
        TodoItem(text: "Тест айтема в одну строку", deadline: Date().addingTimeInterval(2 * 86400), hexColor: "#FFFFFF"),
        TodoItem(text: "Тест айтема в \n 2 строки", deadline: Date().addingTimeInterval(3 * 86400), hexColor: "#FF0000"),
        TodoItem(text: "Тест айтема в \n 3 строки \n и более \n тут типа должно обрезаться", deadline: Date().addingTimeInterval(2 * 86400), hexColor: "#FFFF00"),
        TodoItem(text: "Низкий приоритет", importance: .unimportant, deadline: Date().addingTimeInterval(4 * 86400), hexColor: "#FF00FF"),
        TodoItem(text: "Высокий приоритет", importance: .important, deadline: Date().addingTimeInterval(5 * 86400), hexColor: "#FF00FF"),
        TodoItem(text: "Выполненный айтем", deadline: Date().addingTimeInterval(6 * 86400), isCompleted: true, hexColor: "#00FF00"),
        TodoItem(text: "Айтем с дедлайном", deadline: Date().addingTimeInterval(7 * 86400), hexColor: "#0000FF"),
        TodoItem(text: "Купить что-то, где-то, зачем-то, но зачем не очень понятно, но точно чтобы пок…", deadline: Date(), hexColor: "#00FFFF"),
        TodoItem(text: "Купить что-то, где-то, зачем-то, но зачем не очень понятно, но точно чтобы пок…", hexColor: "#FFFF00"),
        TodoItem(text: "Задание", importance: .important, deadline: Date(), hexColor: "#0FF0FF")
    ]
}

//
//  TodotifyTests.swift
//  TodotifyTests
//
//  Created by kalmahik on 21.06.2024.
//

import XCTest
@testable import Todotify

final class TodotifyJSONAbleTests: XCTestCase {

    // хороший случай, когда есть все поля JSON-a, и их тип соответствует модели
    func testParseValidAndFullJSONDictionary() {
        let jsonDictionary: JSONDictionary = [
            TodoCodingKeys.id.rawValue: TodoItemTestValues.id,
            TodoCodingKeys.text.rawValue: TodoItemTestValues.text,
            TodoCodingKeys.importance.rawValue: TodoItemTestValues.important.rawValue,
            TodoCodingKeys.isCompleted.rawValue: true,
            TodoCodingKeys.createdAt.rawValue: TodoItemTestValues.date,
            TodoCodingKeys.deadline.rawValue: TodoItemTestValues.date,
            TodoCodingKeys.editedAt.rawValue: TodoItemTestValues.date
        ]

        let todoItem = TodoItem.parse(jsonDictionary: jsonDictionary)

        XCTAssertNotNil(todoItem)
        XCTAssertEqual(todoItem?.id, TodoItemTestValues.id)
        XCTAssertEqual(todoItem?.text, TodoItemTestValues.text)
        XCTAssertEqual(todoItem?.importance, .important)
        XCTAssertEqual(todoItem?.isCompleted, true)
        XCTAssertEqual(todoItem?.createdAt, Date.fromString(TodoItemTestValues.date))
        XCTAssertEqual(todoItem?.deadline, Date.fromString(TodoItemTestValues.date))
        XCTAssertEqual(todoItem?.editedAt, Date.fromString(TodoItemTestValues.date))
    }

    // хороший случай, когда есть только обязательные поля JSON-a, и их тип соответствует модели
    func testParseValidAndMinimalJSONDictionary() {
        let jsonDictionary: JSONDictionary = [
            TodoCodingKeys.id.rawValue: TodoItemTestValues.id,
            TodoCodingKeys.text.rawValue: TodoItemTestValues.text,
            TodoCodingKeys.isCompleted.rawValue: true,
            TodoCodingKeys.createdAt.rawValue: TodoItemTestValues.date
        ]

        let todoItem = TodoItem.parse(jsonDictionary: jsonDictionary)

        XCTAssertNotNil(todoItem)
        XCTAssertEqual(todoItem?.id, TodoItemTestValues.id)
        XCTAssertEqual(todoItem?.text, TodoItemTestValues.text)
        XCTAssertEqual(todoItem?.importance, .usual)
        XCTAssertEqual(todoItem?.isCompleted, true)
        XCTAssertEqual(todoItem?.createdAt, Date.fromString(TodoItemTestValues.date))
        XCTAssertNil(todoItem?.deadline)
        XCTAssertNil(todoItem?.editedAt)
    }

    // хороший случай, когда есть только обязательные поля JSON-a, но один (некритичный) тип не соответствует модели
    func testParseInValidAndMinimalJSONDictionary() {
        let jsonDictionary: JSONDictionary = [
            TodoCodingKeys.id.rawValue: TodoItemTestValues.id,
            TodoCodingKeys.text.rawValue: TodoItemTestValues.text,
            TodoCodingKeys.isCompleted.rawValue: TodoItemTestValues.text, // <-- вот тут
            TodoCodingKeys.createdAt.rawValue: TodoItemTestValues.date
        ]

        let todoItem = TodoItem.parse(jsonDictionary: jsonDictionary)

        XCTAssertNotNil(todoItem)
        XCTAssertEqual(todoItem?.id, TodoItemTestValues.id)
        XCTAssertEqual(todoItem?.text, TodoItemTestValues.text)
        XCTAssertEqual(todoItem?.importance, .usual)
        XCTAssertEqual(todoItem?.isCompleted, false)
        XCTAssertEqual(todoItem?.createdAt, Date.fromString(TodoItemTestValues.date))
        XCTAssertNil(todoItem?.deadline)
        XCTAssertNil(todoItem?.editedAt)
    }

    // плохой случай, отсутствует обязательное поле text
    func testParseInValidJSONDictionary() {
        let jsonDictionary: JSONDictionary = [
            TodoCodingKeys.id.rawValue: TodoItemTestValues.id,
            TodoCodingKeys.importance.rawValue: TodoItemTestValues.important.rawValue,
            TodoCodingKeys.isCompleted.rawValue: true,
            TodoCodingKeys.createdAt.rawValue: TodoItemTestValues.date,
            TodoCodingKeys.deadline.rawValue: TodoItemTestValues.date,
            TodoCodingKeys.editedAt.rawValue: TodoItemTestValues.date
        ]

        let todoItem = TodoItem.parse(jsonDictionary: jsonDictionary)

        XCTAssertNil(todoItem)
    }

    // хороший случай, есть все поля
    func testTodoItemFullToJSON() {
        let todoItem = TodoItem(
            id: TodoItemTestValues.id,
            text: TodoItemTestValues.text,
            importance: .important,
            deadline: Date.fromString(TodoItemTestValues.date),
            isCompleted: true,
            createdAt: Date.fromString(TodoItemTestValues.date)!,
            editedAt: Date.fromString(TodoItemTestValues.date)
        )

        let json = todoItem.json as? JSONDictionary

        XCTAssertNotNil(json)
        XCTAssertEqual(json?[TodoCodingKeys.id.rawValue] as? String, TodoItemTestValues.id)
        XCTAssertEqual(json?[TodoCodingKeys.text.rawValue] as? String, TodoItemTestValues.text)
        XCTAssertEqual(json?[TodoCodingKeys.importance.rawValue] as? String, TodoItemTestValues.important.rawValue)
        XCTAssertEqual(json?[TodoCodingKeys.isCompleted.rawValue] as? Bool, true)
        XCTAssertEqual(json?[TodoCodingKeys.createdAt.rawValue] as? String, TodoItemTestValues.date)
        XCTAssertEqual(json?[TodoCodingKeys.deadline.rawValue] as? String, TodoItemTestValues.date)
        XCTAssertEqual(json?[TodoCodingKeys.editedAt.rawValue] as? String, TodoItemTestValues.date)
    }

    // хороший случай, есть только обязательные поля
    func testTodoItemMinimalToJSON() {
        let todoItem = TodoItem(
            text: TodoItemTestValues.text
        )

        let json = todoItem.json as? JSONDictionary

        XCTAssertNotNil(json)
        XCTAssertEqual(json?[TodoCodingKeys.id.rawValue] as? String, todoItem.id)
        XCTAssertEqual(json?[TodoCodingKeys.text.rawValue] as? String, TodoItemTestValues.text)
        XCTAssertNil(json?[TodoCodingKeys.importance.rawValue] as? String)
        XCTAssertEqual(json?[TodoCodingKeys.isCompleted.rawValue] as? Bool, false)
        XCTAssertEqual(json?[TodoCodingKeys.createdAt.rawValue] as? String, todoItem.createdAt.asString())
        XCTAssertEqual(json?[TodoCodingKeys.deadline.rawValue] as? String, todoItem.deadline?.asString())
        XCTAssertEqual(json?[TodoCodingKeys.editedAt.rawValue] as? String, todoItem.editedAt?.asString())
    }
}

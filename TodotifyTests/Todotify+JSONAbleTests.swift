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
            TodoCodingKeys.createdAt.rawValue: TodoItemTestValues.date,
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
    
    // плохой случай, когда есть только обязательные поля JSON-a, но один тип не соответствует модели
    func testParseInValidAndMinimalJSONDictionary() {
        let jsonDictionary: JSONDictionary = [
            TodoCodingKeys.id.rawValue: TodoItemTestValues.id,
            TodoCodingKeys.text.rawValue: TodoItemTestValues.text,
            TodoCodingKeys.isCompleted.rawValue: TodoItemTestValues.text, //<-- вот тут
            TodoCodingKeys.createdAt.rawValue: TodoItemTestValues.date,
        ]
        
        let todoItem = TodoItem.parse(jsonDictionary: jsonDictionary)
        
        XCTAssertNil(todoItem)
    }
    
    // плохой случай, отсутствует обязательное поле isCompleted
    func testParseInValidJSONDictionary() {
        let jsonDictionary: JSONDictionary = [
            TodoCodingKeys.id.rawValue: TodoItemTestValues.id,
            TodoCodingKeys.text.rawValue: TodoItemTestValues.text,
            TodoCodingKeys.createdAt.rawValue: TodoItemTestValues.date,
        ]
        
        let todoItem = TodoItem.parse(jsonDictionary: jsonDictionary)
        
        XCTAssertNil(todoItem)
    }
    
//    func testTodoItemToJSON() {
//        let todoItem = TodoItem(
//            id: TodoItemTestValues.id,
//            text: TodoItemTestValues.text,
//            importance: .important,
//            deadline: Date(),
//            isCompleted: true,
//            createdAt: Date.fromString("2024-06-17T00:00:00Z")!,
//            editedAt: Date.fromString("2024-06-19T00:00:00Z")
//        )
//        
//        let json = todoItem.json as? JSONDictionary
//        
//        XCTAssertNotNil(json)
//        XCTAssertEqual(json?["id"] as? String, "123")
//        XCTAssertEqual(json?["text"] as? String, "Test Todo")
//        XCTAssertEqual(json?["importance"] as? String, "important")
//        XCTAssertEqual(json?["isCompleted"] as? Bool, true)
//        XCTAssertEqual(json?["createdAt"] as? String, "2024-06-17T00:00:00Z")
//        XCTAssertEqual(json?["deadline"] as? String, "2024-06-18T00:00:00Z")
//        XCTAssertEqual(json?["editedAt"] as? String, "2024-06-19T00:00:00Z")
//    }
}

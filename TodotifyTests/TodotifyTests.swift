//
//  TodotifyTests.swift
//  TodotifyTests
//
//  Created by kalmahik on 21.06.2024.
//

import XCTest
@testable import Todotify

final class TodotifyTests: XCTestCase {
    
    func testTodoItemMinimal() {
        let text = TodoItemTestValues.text
        let todo = TodoItem(text: text)
        XCTAssertNotNil(todo.id)
        XCTAssertEqual(todo.text, text)
        XCTAssertEqual(todo.importance, Importance.usual)
        XCTAssertNil(todo.deadline)
        XCTAssertFalse(todo.isCompleted)
        XCTAssertNotNil(todo.createdAt)
        XCTAssertNil(todo.editedAt)
    }
    
    func testTodoItemFull() {
        let id = TodoItemTestValues.id
        let text = TodoItemTestValues.text
        let importance = Importance.important
        let deadline = Date()
        let isCompleted = true
        let createdAt = Date()
        let editedAt = Date()
        
        let todo = TodoItem(
            id: id,
            text: text,
            importance: importance,
            deadline: deadline,
            isCompleted: isCompleted,
            createdAt: createdAt,
            editedAt: editedAt
        )
        
        XCTAssertEqual(todo.id, id)
        XCTAssertEqual(todo.text, text)
        XCTAssertEqual(todo.importance, importance)
        XCTAssertEqual(todo.deadline, deadline)
        XCTAssertEqual(todo.isCompleted, isCompleted)
        XCTAssertEqual(todo.createdAt, createdAt)
        XCTAssertEqual(todo.editedAt, editedAt)
    }
    
}

//
//  DefaultValues.swift
//  TodotifyTests
//
//  Created by kalmahik on 21.06.2024.
//

import Foundation
@testable import Todotify

struct TodoItemTestValues {
    static let id = UUID().uuidString
    static let text = "Do some task"
    static let date = "2024-06-22T06:00:00Z"
    static let usual = Importance.usual
    static let important = Importance.important
}

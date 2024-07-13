//
//  Todotify+URLSessionTests.swift
//  TodotifyTests
//
//  Created by kalmahik on 12.07.2024.
//

@testable import Todotify
import XCTest

final class TodotifyURLSessionTests: XCTestCase {

    func testDataTask() async throws {
        let request = URLRequest(url: URL(string: "https://ya.ru")!)
        let (data, _) = try await URLSession.shared.dataTask(for: request)

        XCTAssertNotNil(data)
    }

    func testDataTaskCancellation() async {
        let request = URLRequest(url: URL(string: "https://ya.ru")!)

        let task = Task {
            do {
                let (_, _) = try await URLSession.shared.dataTask(for: request)
                XCTFail("Expected to be cancelled, but it succeeded")
            } catch {
                XCTAssertEqual((error as? URLError)?.code, .cancelled, "Expected cancelation error")
            }
        }

        task.cancel()
    }
}

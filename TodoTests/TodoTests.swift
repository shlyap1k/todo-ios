//
//  todo_iosTests.swift
//  todo-iosTests
//
//  Created by Shlyap1k on 07.12.2024.
//

import XCTest
@testable import Todo

final class TodoTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testData() throws {
        let vm = TodoListVM()
        let todo = Todo(id: 2, dateStart: .init(), dateFinish: .init(), name: "задача", descriptionText: "обновлено")
        let result = vm.save(todo)
        switch result {
        case .success:
            assert(true)
        case let  .failure(failure):
            print(failure.localizedDescription)
            assert(false)
        }
    }
    
    func testFetch() throws {
        let vm = TodoListVM()
        let todos = vm.getTodos(for: .init())
        if let todos {
            print(Array(todos))
            assert(true)
        } else {
            assert(false)
        }
    }
}

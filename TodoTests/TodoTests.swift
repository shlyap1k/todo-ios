//
//  todo_iosTests.swift
//  todo-iosTests
//
//  Created by Shlyap1k on 07.12.2024.
//

import XCTest
@testable import Todo

final class TodoTests: XCTestCase {
    private var testTodoRepository: TodoRepository?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.testTodoRepository = TodoRepositoryImpl(storage: StorageServiceImpl(.test))
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
    
    func testDataBase() throws {
        XCTAssertTrue(saveData())
        XCTAssertTrue(fetchData())
    }
    
    func saveData() -> Bool {
        let todo = TodoDTO(id: 3, dateStart: .init(), dateFinish: .init(), name: "задачи1000", descriptionText: "обновлено")
        testTodoRepository?.saveTodo(todo)
        return true
    }
    
    func fetchData() -> Bool {
        let todoList = testTodoRepository?.getTodoList()
        return todoList?.contains(where: {$0.name == "задачи1000"}) == true
    }
}

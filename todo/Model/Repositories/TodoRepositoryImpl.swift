//
//  TodoRepositoryImpl.swift
//  Todo
//
//  Created by Shlyap1k on 09.12.2024.
//

import Foundation

final class TodoRepositoryImpl: TodoRepository {
    
    init(storage: StorageService) {
        self.storage = storage
    }
    func getTodoList() -> [TodoDTO] {
        let data = storage.fetch(by: TodoObject.self)
        return data.map(TodoDTO.init)
    }
    
    func saveTodo(_ todo: TodoDTO) {
        let object = TodoObject(dto: todo)
        try? storage.saveOrUpdateObject(object: object)
    }
    
    func clearTodoList() {
        try? storage.deleteAll()
    }
    
    private let storage: StorageService
}

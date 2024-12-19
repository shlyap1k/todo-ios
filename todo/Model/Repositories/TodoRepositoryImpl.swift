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
        let data = storage.fetch(by: TodoObject.self, filter: nil)
        return data.map(TodoDTO.init)
    }
    
    func getTodoList(for date: Date) -> [TodoDTO] {
        let startOfDay = Calendar.current.startOfDay(for: date)
        let endOfDay = Calendar.current.date(byAdding: .day, value: 1, to: startOfDay)!
        
        let predicate = NSPredicate(format: "dateStart >= %@ AND dateStart < %@", startOfDay as NSDate, endOfDay as NSDate)
        let todos: [TodoDTO] = storage.fetch(by: TodoObject.self, filter: predicate).map(TodoDTO.init)
        return todos
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

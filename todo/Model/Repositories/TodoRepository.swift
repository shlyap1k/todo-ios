//
//  File.swift
//  Todo
//
//  Created by Shlyap1k on 09.12.2024.
//

import Foundation
import RealmSwift

protocol TodoRepository {
    func getTodoList() -> [TodoDTO]
    
    func getTodoList(for date: Date) -> [TodoDTO]
    
    func saveTodo(_ todo: TodoDTO)
    
    func clearTodoList()
}

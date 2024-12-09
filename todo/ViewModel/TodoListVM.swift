//
//  TodoListVM.swift
//  todo-ios
//
//  Created by Shlyap1k on 07.12.2024.
//

import Foundation
import RxCocoa
import RxSwift
import RealmSwift

class TodoListVM {
    let selectedDate = BehaviorRelay<Date>(value: Date())
    let todos: BehaviorRelay<[TodoDTO]> = BehaviorRelay(value: [])
    
    private var todoRepository: TodoRepository
    private let disposeBag = DisposeBag()

    init() {
        todoRepository = TodoRepositoryImpl(storage: StorageServiceImpl(.app))
        selectedDate
            .asObservable()
            .subscribe(onNext: { [weak self] date in
                guard let self, let todos = self.getTodos(for: date) else { return }
                let results = Array(todos)
                self.todos.accept(results)
            })
            .disposed(by: disposeBag)
    }
    
    public func save(_ todo: TodoDTO) {
        todoRepository.saveTodo(todo)
    }

    func getTodos(for date: Date) -> [TodoDTO]? {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay) ?? startOfDay

        return todoRepository.getTodoList()//.filter("dateStart >= %@ AND dateStart < %@", startOfDay, endOfDay)
    }
}

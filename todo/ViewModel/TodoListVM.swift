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
    let todos: BehaviorRelay<[HourTodo]> = BehaviorRelay(value: [])
    
    var todoRepository: TodoRepository
    private let router: Router
    private let disposeBag = DisposeBag()

    init(router: Router) {
        todoRepository = TodoRepositoryImpl(storage: StorageServiceImpl(.app))
        self.router = router
        selectedDate
            .asObservable()
            .subscribe(onNext: { [weak self] date in
                guard let self, let todos = self.getTodos(for: date) else { return }
                var result: [HourTodo] = []
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "HH:mm"
                let hoursFormatter = DateFormatter()
                hoursFormatter.dateFormat = "HH"
                
                for hour in 0..<24 {
                    let date = Calendar.current.date(bySettingHour: hour, minute: 0, second: 0, of: Date())!
                    let matchingTodo = todos.first { todo in
                        hoursFormatter.string(from: todo.dateStart) == hoursFormatter.string(from: date)
                    }
                    result.append(HourTodo(hour: dateFormatter.string(from: date), todo: matchingTodo))
                }

                self.todos.accept(result)
            })
            .disposed(by: disposeBag)
    }
    
    func openAddTaskScreen() {
        router.push(to: AddTodoViewController(viewModel: .init(todoRepository: todoRepository, router: router)), animated: true)
    }
    
    func showDetail(for selected: TodoDTO) {
        router.push(to: TodoDetailViewController(todo: selected), animated: true)
    }

    func getTodos(for date: Date) -> [TodoDTO]? {
        return todoRepository.getTodoList(for: date)
    }
}

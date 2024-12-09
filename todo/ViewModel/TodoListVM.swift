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
    let todos: BehaviorRelay<[Todo]> = BehaviorRelay(value: [])
    
    private var realm: Realm?
    private let disposeBag = DisposeBag()

    init(
        _ configuration: Realm.Configuration = Realm.Configuration(
            inMemoryIdentifier: "inMemory"
        )
    ) {
        realm = try? Realm()
        print(realm?.configuration.fileURL)
        selectedDate
            .asObservable()
            .subscribe(onNext: { [weak self] date in
                guard let self, let todos = self.getTodos(for: date) else { return }
                let results = Array(todos)
                self.todos.accept(results)
            })
            .disposed(by: disposeBag)
    }
    
    public func save<T: Object>(_ object: T) -> Result<Void, Error> {
        do {
            try realm?.write {
                realm?.add(object, update: .modified)
            }
        } catch {
            return .failure(error)
        }
        return .success(Void())
    }

    func getTodos(for date: Date) -> Results<Todo>? {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay) ?? startOfDay

        return realm?.objects(Todo.self)//.filter("dateStart >= %@ AND dateStart < %@", startOfDay, endOfDay)
    }
}

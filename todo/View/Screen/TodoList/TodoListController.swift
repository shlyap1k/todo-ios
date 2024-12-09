//
//  TodoListController.swift
//  todo-ios
//
//  Created by Shlyap1k on 07.12.2024.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

class TodoListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.todos.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath)
        cell.textLabel?.text = viewModel.todos.value[indexPath.row].name
        cell.accessoryType = .disclosureIndicator // Optional: Adds a chevron for tappable rows
        return cell
    }
    
    private let disposeBag = DisposeBag()
    private let viewModel = TodoListVM()
    private let contentView = TodoListView()
    private let router: Router
    
    init(router: Router) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        contentView.datePicker.rx.date
            .bind(to: viewModel.selectedDate)
            .disposed(by: disposeBag)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedTodo = viewModel.todos.value[indexPath.row]
        showDetail(for: selectedTodo)
    }
    
    private func showDetail(for selected: TodoDTO) {
        router.push(to: TodoDetailViewController(todo: selected), animated: true)
    }

    private func bindViewModel() {
        viewModel.todos
            .bind(to: contentView.tableView.rx.items(cellIdentifier: "TodoCell", cellType: UITableViewCell.self)) { index, todo, cell in
                cell.textLabel?.text = "\(todo.name) (\(todo.dateStart))"
            }
            .disposed(by: disposeBag)
        
        // Add the tap action to the table view cells
        contentView.tableView.rx.modelSelected(TodoDTO.self)
            .subscribe(onNext: { todo in
                self.showDetail(for: todo)
            })
            .disposed(by: disposeBag)
    }
}

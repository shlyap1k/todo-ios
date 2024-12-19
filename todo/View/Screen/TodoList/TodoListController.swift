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
        if let todo = viewModel.todos.value[indexPath.row].todo {
            cell.textLabel?.text = "\(viewModel.todos.value[indexPath.row].hour) \(todo.name)"
        } else {
            cell.textLabel?.text = viewModel.todos.value[indexPath.row].hour
        }
        cell.accessoryType = .disclosureIndicator // Optional: Adds a chevron for tappable rows
        return cell
    }
    
    private let disposeBag = DisposeBag()
    private let viewModel: TodoListVM
    private let contentView = TodoListView()
    
    init(viewModel: TodoListVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    private func setupActions() {
        contentView.addTaskButton.addTarget(self, action: #selector(openAddTask), for: .touchUpInside)
    }
    
    @objc private func openAddTask() {
        viewModel.openAddTaskScreen()
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
        setupActions()
        contentView.datePicker.rx.date
            .bind(to: viewModel.selectedDate)
            .disposed(by: disposeBag)
    }

    private func bindViewModel() {
        viewModel.todos
            .bind(to: contentView.tableView.rx.items(cellIdentifier: "TodoCell", cellType: UITableViewCell.self)) { _, hour, cell in
                if let todo = hour.todo {
                    cell.textLabel?.text = "\(hour.hour) \(todo.name)"
                } else {
                    cell.textLabel?.text = "\(hour.hour)"
                }
            }
            .disposed(by: disposeBag)
        
        // Add the tap action to the table view cells
        
        contentView.tableView.rx.modelSelected(HourTodo.self)
            .subscribe(onNext: { [weak self] hour in
                if let todo = hour.todo {
                    self?.viewModel.showDetail(for: todo)
                }
                // Deselect the row after tapping
                if let indexPath = self?.contentView.tableView.indexPathForSelectedRow {
                    self?.contentView.tableView.deselectRow(at: indexPath, animated: true)
                }
            })
            .disposed(by: disposeBag)
    }
}

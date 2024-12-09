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

class TodoListViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let viewModel = TodoListVM()
    private let contentView = TodoListView()
    init() {
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

    private func bindViewModel() {
        viewModel.todos
            .bind(to: contentView.tableView.rx.items(cellIdentifier: "TodoCell", cellType: UITableViewCell.self)) { index, todo, cell in
                cell.textLabel?.text = "\(todo.name) (\(todo.dateStart))"
            }
            .disposed(by: disposeBag)
    }
}

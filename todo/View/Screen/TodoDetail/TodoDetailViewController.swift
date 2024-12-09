//
//  TodoDetailViewController.swift
//  todo-ios
//
//  Created by Shlyap1k on 07.12.2024.
//

import Foundation
import UIKit

class TodoDetailViewController: UIViewController {
    
    var todo: TodoDTO
    
    private let todoDetailView = TodoDetailView()
    
    init(todo: TodoDTO) {
        self.todo = todo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the view controller
        view.backgroundColor = .white
        setupTodoDetailView()
        
        // Set navigation bar title
        navigationItem.title = todo.name
        
        // Pass the TodoDTO to the custom view
        todoDetailView.todo = todo
    }
    
    private func setupTodoDetailView() {
        todoDetailView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(todoDetailView)
        
        // Layout the custom view
        NSLayoutConstraint.activate([
            todoDetailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            todoDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            todoDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            todoDetailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

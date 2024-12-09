//
//  TodoDetailController.swift
//  Todo
//
//  Created by Shlyap1k on 09.12.2024.
//

import Foundation
import UIKit

class TodoDetailView: UIView {
    
    // UI Elements
    private let nameLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let startDateLabel = UILabel()
    private let finishDateLabel = UILabel()
    
    var todo: TodoDTO? {
        didSet {
            updateUI()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        // Configure the labels
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        startDateLabel.translatesAutoresizingMaskIntoConstraints = false
        finishDateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.font = .boldSystemFont(ofSize: 20)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = .systemFont(ofSize: 16)
        startDateLabel.font = .systemFont(ofSize: 16)
        finishDateLabel.font = .systemFont(ofSize: 16)
        
        addSubview(nameLabel)
        addSubview(descriptionLabel)
        addSubview(startDateLabel)
        addSubview(finishDateLabel)
        
        // Layout the UI elements
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            startDateLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            startDateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            startDateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            finishDateLabel.topAnchor.constraint(equalTo: startDateLabel.bottomAnchor, constant: 20),
            finishDateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            finishDateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
    }
    
    private func updateUI() {
        guard let todo = todo else { return }
        
        nameLabel.text = todo.name
        descriptionLabel.text = todo.descriptionText
        startDateLabel.text = "Дата начала: \(formatDate(todo.dateStart))"
        finishDateLabel.text = "Дата окончания: \(formatDate(todo.dateFinish))"
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

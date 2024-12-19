//
//  AddTodoView.swift
//  todo-ios
//
//  Created by Shlyap1k on 07.12.2024.
//

import Foundation
import UIKit

class AddTodoView: UIView {
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Название задачи"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 1.0
        textView.layer.cornerRadius = 8.0
        textView.isScrollEnabled = false
        return textView
    }()
    
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        return datePicker
    }()
    
    private let datePickerLabel: UILabel = {
        let label = UILabel()
        label.text = "Дата"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()

    private lazy var datePickerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [datePickerLabel, datePicker])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let timeStartPicker: UIDatePicker = {
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        return timePicker
    }()
    
    private let timeStartLabel: UILabel = {
        let label = UILabel()
        label.text = "Время начала"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()

    private lazy var timeStartStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [timeStartLabel, timeStartPicker])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let timeFinishPicker: UIDatePicker = {
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        return timePicker
    }()
    
    private let timeFinishLabel: UILabel = {
        let label = UILabel()
        label.text = "Время окончания"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()

    private lazy var timeFinishStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [timeFinishLabel, timeFinishPicker])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Сохранить", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 12
        button.backgroundColor = .gray
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        let stackView = UIStackView(arrangedSubviews: [
            nameTextField,
            descriptionTextView,
            datePickerStackView,
            timeStartStackView,
            timeFinishStackView,
            saveButton
        ])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16)
        ])
        
        descriptionTextView.heightAnchor.constraint(equalToConstant: 120).isActive = true // Ограничение на высоту TextView
    }
}

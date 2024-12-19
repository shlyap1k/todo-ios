import UIKit

class AddTodoViewController: UIViewController {
    init(viewModel: AddTodoVM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let viewModel: AddTodoVM
    private let addTodoView = AddTodoView()
    
    override func loadView() {
        view = addTodoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupAddTodoView()
        setupActions()
    }
    
    private func setupActions() {
        addTodoView.saveButton.addTarget(self, action: #selector(saveTask), for: .touchUpInside)
    }
    
    @objc private func saveTask() {
        guard let name = addTodoView.nameTextField.text, !name.isEmpty else {
            showError(message: "Введите название задачи")
            return
        }
        
        viewModel.name = name
        viewModel.description = addTodoView.descriptionTextView.text
        viewModel.selectedDate = addTodoView.datePicker.date
        viewModel.timeStart = addTodoView.timeStartPicker.date
        viewModel.timeFinish = addTodoView.timeFinishPicker.date
        
        viewModel.saveTodo()
    }
    
    private func showError(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .default))
        present(alert, animated: true)
    }
    
    
    private func setupAddTodoView() {
//        addTodoView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(addTodoView)
//        
//        // Layout the custom view
//        NSLayoutConstraint.activate([
//            addTodoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            addTodoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            addTodoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            addTodoView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
//        ])
    }
}

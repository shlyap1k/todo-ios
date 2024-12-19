import Foundation

class AddTodoVM {
    
    init(todoRepository: TodoRepository, router: Router) {
        self.todoRepository = todoRepository
        self.router = router
    }
    
    var name: String = ""
    var description: String = ""
    var selectedDate: Date = Date()
    var timeStart: Date = Date()
    var timeFinish: Date = Date()
    
    private var todoRepository: TodoRepository
    private let router: Router
    
    private func createTodo() -> TodoDTO {
        let id = Int.random(in: 1...1000) // Генерация уникального ID
        let dateStart = merge(date: selectedDate, time: timeStart)
        let dateFinish = merge(date: selectedDate, time: timeFinish)
        
        return TodoDTO(
            id: id,
            dateStart: dateStart,
            dateFinish: dateFinish,
            name: name,
            descriptionText: description
        )
    }
    
    private func merge(date: Date, time: Date) -> Date {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        let timeComponents = calendar.dateComponents([.hour, .minute], from: time)
        
        var mergedComponents = DateComponents()
        mergedComponents.year = dateComponents.year
        mergedComponents.month = dateComponents.month
        mergedComponents.day = dateComponents.day
        mergedComponents.hour = timeComponents.hour
        mergedComponents.minute = timeComponents.minute
        
        return calendar.date(from: mergedComponents) ?? date
    }
    
    func saveTodo() {
        let todo = createTodo()
        todoRepository.saveTodo(todo)
        router.pop(animated: true)
    }
}

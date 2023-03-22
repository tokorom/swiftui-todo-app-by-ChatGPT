import SwiftUI
import Combine

class TaskStore: ObservableObject {
    @Published var tasks: [Task] = [] {
        didSet {
            saveTasks()
        }
    }

    private let tasksKey = "tasksKey"

    init() {
        tasks = loadTasks()
    }

    func addTask(title: String) {
        tasks.append(Task(title: title))
    }

    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }

    func toggleTaskCompletion(at index: Int) {
        tasks[index].isCompleted.toggle()
    }

    private func saveTasks() {
        if let encodedTasks = try? JSONEncoder().encode(tasks) {
            UserDefaults.standard.set(encodedTasks, forKey: tasksKey)
        }
    }

    private func loadTasks() -> [Task] {
        if let tasksData = UserDefaults.standard.data(forKey: tasksKey),
           let decodedTasks = try? JSONDecoder().decode([Task].self, from: tasksData) {
            return decodedTasks
        }
        return []
    }
}

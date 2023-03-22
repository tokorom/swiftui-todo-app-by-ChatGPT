import SwiftUI
import Combine

class TaskStore: ObservableObject {
    @Published var tasks: [Task] = []

    func addTask(title: String) {
        tasks.append(Task(title: title))
    }

    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }

    func toggleTaskCompletion(at index: Int) {
        tasks[index].isCompleted.toggle()
    }
}

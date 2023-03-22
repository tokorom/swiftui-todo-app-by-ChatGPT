import SwiftUI

struct ContentView: View {
    @StateObject private var taskStore = TaskStore()
    @State private var newTaskTitle = ""

    var body: some View {
        VStack {
            Text("ToDoリスト")
                .font(.largeTitle)
                .padding()

            List {
                ForEach(taskStore.tasks) { task in
                    HStack {
                        Text(task.title)
                            .strikethrough(task.isCompleted, color: .black)

                        Spacer()

                        Button(action: {
                            taskStore.toggleTaskCompletion(at: taskStore.tasks.firstIndex(where: { $0.id == task.id })!)
                        }) {
                            Image(systemName: task.isCompleted ? "checkmark.square" : "square")
                        }
                    }
                }
                .onDelete(perform: taskStore.deleteTask)
            }
            .listStyle(InsetGroupedListStyle())
            
            VStack {
                TextField("新しいタスクを追加", text: $newTaskTitle, onCommit: {
                    taskStore.addTask(title: newTaskTitle)
                    newTaskTitle = ""
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

                Button("タスクを追加", action: {
                    taskStore.addTask(title: newTaskTitle)
                    newTaskTitle = ""
                })
                .disabled(newTaskTitle.isEmpty)
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

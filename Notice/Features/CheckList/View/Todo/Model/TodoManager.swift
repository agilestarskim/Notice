//
//  TodoViewModel.swift
//  Notice
//
//  Created by 김민성 on 12/23/23.
//

import SwiftData
import SwiftUI

final class TodoManager: ObservableObject {        
    @Published var todos: [Todo] = []
    @Published var shouldShowDone = true
    @Published var shouldOpenEditor = false
    @Published var editingTodo: Todo?
    
    private let context: ModelContext
    private let calendar: Calendar = Calendar.shared
    
    init(context: ModelContext) {
        self.context = context
        fetchTodos()
    }
    
    func fetchTodos() {
        let sort = [
            SortDescriptor(\Todo.isDone),
            SortDescriptor(\Todo.flag, order: .reverse),
            SortDescriptor(\Todo.date)
        ]
        
        let fetchDescriptor = FetchDescriptor(predicate: predicate, sortBy: sort)
        
        do {
            self.todos = try context.fetch(fetchDescriptor)
        } catch {
            print("Fail to fetch Todos")
        }
    }
    
    func onTapPlusButton() {
        shouldOpenEditor = true        
    }
    
    func onTapEditButton(todo: Todo) {
        editingTodo = todo
    }
    
    func create(_ todo: Todo) {
        context.insert(todo)
        fetchTodos()
    }
    
    func update(_ newTodo: Todo) {
        if let origin = editingTodo {
            context.delete(origin)
            context.insert(newTodo)
            fetchTodos()
        }
    }
    
    func delete(_ todo: Todo) {
        context.delete(todo)
        fetchTodos()
    }
    
    func toggleDone(_ todo: Todo) {
        todo.isDone.toggle()
        
        todo.subTodos?.forEach {
            $0.isDone = todo.isDone
        }
        slowMotion {
            self.fetchTodos()
        }
    }
    
    func toggleSubTodoDone(_ subTodo: SubTodo, of todo: Todo) {
        subTodo.isDone.toggle()
        
        if subTodo.isDone == false && todo.isDone == true {
            todo.isDone = false
        }
        
        if let subTodos = todo.subTodos, subTodos.allSatisfy({$0.isDone}) {
            todo.isDone = true
        }
        
        slowMotion {
            self.fetchTodos()
        }
    }
    
    func todoState(_ todo: Todo) -> TodoState {
        if calendar.isDate(todo.date, inSameDayAs: .now) {
            return .today
        } else if todo.date < .now && !todo.isDone {
            return .over
        } else {
            return .none
        }
    }
    
    func doneButtonImage(_ isDone: Bool) -> Image {
        if isDone {
            return Image(systemName: "circle.circle.fill")
        } else {
            return Image(systemName: "circle")
        }
    }
    
    private var predicate: Predicate<Todo> {
        if shouldShowDone {
            return #Predicate<Todo> { todo in
                true
            }
        } else {
            return #Predicate<Todo> { todo in
                !todo.isDone
            }
        }
    }
    
    private func slowMotion(_ excute: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            excute()
        }
    }
}

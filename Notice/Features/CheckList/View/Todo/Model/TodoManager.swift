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
    @Published var todoFilter: TodoFilter = .today
    @Published var goingRight: Bool = false
    @Published var shouldOpenEditor = false
    @Published var editingTodo: Todo?
    
    private let context: ModelContext
    private let calendar: Calendar = Calendar.shared
    
    var todayTodos: [Todo] {
        todos.filter { calendar.isDateInToday($0.date) }
    }
    
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
        
        let fetchDescriptor = FetchDescriptor(sortBy: sort)
        
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
    
    func setTabDirection(prevTab: TodoFilter, currentTab: TodoFilter) {
        if prevTab.index - currentTab.index < 0 {
            self.goingRight = true
        } else {
            self.goingRight = false
        }
    }
    
    func create(_ todo: Todo) {
        context.insert(todo)
        fetchTodos()
    }
    
    func update(_ newTodo: Todo) {
        if let origin = editingTodo {
            context.delete(origin)
            context.insert(newTodo)
        }
        fetchTodos()
    }
    
    func delete(_ todo: Todo) {
        context.delete(todo)
        fetchTodos()
    }
    
    func toggleDone(_ todo: Todo) {
        todo.isDone.toggle()
        
        todo.subTodos.forEach {
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
        
        if todo.subTodos.allSatisfy({$0.isDone}) {
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
    
    private func slowMotion(_ excute: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            excute()
        }
    }
}

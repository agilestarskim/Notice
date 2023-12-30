//
//  TodoViewModel.swift
//  Notice
//
//  Created by 김민성 on 12/23/23.
//

import SwiftData
import SwiftUI

final class TodoViewModel: ObservableObject {
        
    @Published var todos: [Todo] = []
    @Published var filter: Filter = .all
    @Published var isOpenEditorToCreate = false
    @Published var editingTodo: Todo?
    
    private let context: ModelContext
    
    let calendar: Calendar = {
        var calendar = Calendar.current
        calendar.locale = .current
        calendar.timeZone = .current
        return calendar
    }()
    
    init(context: ModelContext) {
        self.context = context
        fetchTodos()
    }
    
    func onTapPlusButton() {
        isOpenEditorToCreate = true
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
    
    func toggleSubtodoDone(_ subTodo: SubTodo, of todo: Todo) {
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
    
    func doneButtonImage(_ isDone: Bool) -> Image {
        if isDone {
            return Image(systemName: "circle.circle.fill")
        } else {
            return Image(systemName: "circle")
        }
    }
    
    func fetchTodos() {
        let sort = [SortDescriptor(\Todo.date)]
        let fetchDescriptor = FetchDescriptor(predicate: predicate, sortBy: sort)
        
        do {
            self.todos = try context.fetch(fetchDescriptor)
        } catch {
            print("Fail to fetch Todos")
        }
    }
    
    private var predicate: Predicate<Todo> {
        switch filter {
        case .all:
            return #Predicate<Todo> { todo in
                !todo.isDone
            }
        case .today:
            let startOfDay = calendar.startOfDay(for: .now)
            let endOfDay = calendar.date(bySettingHour: 23, minute: 59, second: 59, of: .now) ?? .distantFuture
            return #Predicate<Todo> { todo in
                startOfDay <= todo.date && todo.date <= endOfDay && !todo.isDone
            }
        case .done:
            return #Predicate<Todo> { todo in
                todo.isDone
            }
        case .archive:
            return #Predicate<Todo> { todo in
                false
            }
        }
    }
    
    private func slowMotion(_ excute: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            excute()
        }
    }
}


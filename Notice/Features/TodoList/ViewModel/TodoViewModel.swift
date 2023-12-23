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
    @Published var isOpenEditorToEdit = false
    
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
    
    func onTapEditButton() {
        isOpenEditorToEdit = true
    }
    
    func create(_ todo: Todo) {
        context.insert(todo)
        fetchTodos()
    }
    
    func update(origin: Todo, edit: Todo) {
        origin.title = edit.title
        origin.memo = edit.memo
        origin.date = edit.date
        origin.flag = edit.flag
        origin.subTodos = edit.subTodos
        
        fetchTodos()
    }
    
    func toggleDone(_ todo: Todo) {
        todo.isDone.toggle()
        
        fetchTodos()
    }
    
    func doneButtonImage(_ todo: Todo) -> Image {
        if todo.isDone {
            return Image(systemName: "circle.circle.fill")
        } else {
            return Image(systemName: "circle")
        }
    }
    
    var predicate: Predicate<Todo> {
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
    
    func fetchTodos() {    
        let sort = SortDescriptor(\Todo.date)
        
        let fetchDescriptor = FetchDescriptor(predicate: predicate, sortBy: [sort])
        
        do {
            self.todos = try context.fetch(fetchDescriptor)
        } catch {
            print("Fail to fetch Todos")
        }        
    }
}


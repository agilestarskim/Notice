//
//  DBManager.swift
//  Notice
//
//  Created by 김민성 on 1/23/24.
//

import SwiftData
import SwiftUI
import Observation

extension TodoManager {
    @Observable
    final class DBManager {
        var todos: [Todo] = []
        
        private let context: ModelContext
        
        init(context: ModelContext) {
            self.context = context
        }
        
        func create(_ todo: Todo) {
            context.insert(todo)   
            fetch()
        }
        
        func update(origin: Todo, _ newTodo: Todo) {
            context.delete(origin)
            context.insert(newTodo)
            
            let subTodos = newTodo.subTodos ?? []
            if subTodos.allSatisfy({ $0.isDone }) {
                newTodo.isDone = false
            }
            fetch()
        }
        
        func delete(_ todo: Todo) {
            context.delete(todo)
            fetch()
        }
        
        func toggle(_ todo: Todo) {
            todo.isDone.toggle()
            
            todo.subTodos?.forEach {
                $0.isDone = todo.isDone
            }   
            fetch()
        }
        
        func toggle(subTodo: SubTodo, of todo: Todo) {
            subTodo.isDone.toggle()
            
            if subTodo.isDone == false && todo.isDone == true {
                todo.isDone = false
            }
            
            let subTodos = todo.subTodos ?? []
            if subTodos.allSatisfy({$0.isDone}) {
                todo.isDone = true
            }
            fetch()
        }
        
        func fetch() {
            let sort = [
                SortDescriptor(\Todo.isDone),
                SortDescriptor(\Todo.flag, order: .reverse),
                SortDescriptor(\Todo.date)
            ]
            
            let fetchDescriptor = FetchDescriptor(sortBy: sort)
            
            do {
                self.todos = try context.fetch(fetchDescriptor)
            } catch {
                self.todos = []
            }
        }
    }
}


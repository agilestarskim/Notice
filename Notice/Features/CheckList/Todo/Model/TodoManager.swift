//
//  TodoManager2.swift
//  Notice
//
//  Created by 김민성 on 1/23/24.
//

import Foundation
import Observation
import SwiftData

@Observable
final class TodoManager {
    let appState: AppState
    let context: ModelContext
    let formatter: NTFormatter
    let calendar: Calendar
    
    let dbManager: DBManager
    let editManager: EditManager
    let filterManager: FilterManager
    
    init(
        appState: AppState,
        context: ModelContext,
        formatter: NTFormatter = NTFormatter.shared,
        calendar: Calendar = Calendar.autoupdatingCurrent
    ) {
        self.appState = appState
        self.context = context
        self.formatter = formatter
        self.calendar = calendar
        
        self.dbManager = TodoManager.DBManager(context: context)
        self.editManager = TodoManager.EditManager()
        self.filterManager = TodoManager.FilterManager()
    }
    
    var todos: [Todo] {
        dbManager.todos
    }
    
    var todayTodos: [Todo] {
        dbManager.todos.filter { calendar.isDateInToday($0.date) }
    }
    
    func onAppear() {
        appState.onTapPlusButton = self.onTapPlusButton
        dbManager.fetch()
    }
    
    func onTapEditButton(todo: Todo) {
        editManager.editingTodo = todo
        editManager.setData()
    }
    
    func onTapDeleteButton(_ todo: Todo) {
        dbManager.delete(todo)
    }
    
    func onChangeFilter(prev: TodoFilter, current: TodoFilter) {
        filterManager.setTabDirection(prevTab: prev, currentTab: current)
    }
    
    func onTapDoneButton(of todo: Todo) {
        dbManager.toggle(todo)
    }
    
    func onTapDoneButton(subTodo: SubTodo, of todo: Todo) {
        dbManager.toggle(subTodo: subTodo, of: todo)
    }    
    
    func onTapAddSubButton() {
        editManager.addSubTodo()
    }
    
    func onTapDeleteSubButton(_ subTodo: SubTodo) {
        editManager.deleteSubTodo(subTodo: subTodo)
    }
    
    func onTapEditDoneButton() {
        let newTodo = editManager.createNewTodo()
        
        if let origin = editManager.editingTodo {
            dbManager.update(origin: origin, newTodo)            
        } else {
            dbManager.create(newTodo)
        }
        
        editManager.resetData()
    }
    
    //임시
    func todoState(_ todo: Todo) -> TodoState {
        if calendar.isDate(todo.date, inSameDayAs: .now) {
            return .today
        } else if todo.date < .now && !todo.isDone {
            return .over
        } else {
            return .none
        }
    }
    
    // MARK: - Private functions
    
    private func onTapPlusButton() {
        editManager.shouldOpenEditor = true
    }
}



//
//  TodoListView.swift
//  Notice
//
//  Created by 김민성 on 11/6/23.
//

import SwiftUI

struct TodoView: View {
    @Environment(AppState.self) private var appState
    @Environment(TodoManager.self) private var todoManager
    
    var body: some View {
        @Bindable var editManager = todoManager.editManager
        VStack {
            TodoFilterPicker
            TodoList
        }
        .sheet(isPresented: $editManager.shouldOpenEditor) {
            TodoFormView()
        }
        .onAppear(perform: todoManager.onAppear)
    }
    
    var TodoFilterPicker: some View {
        @Bindable var filterManager = todoManager.filterManager
        
        return NTPicker(
            $filterManager.todoFilter.animation(.easeInOut(duration: 0.2)),
            TodoFilter.allCases,
            theme: appState.theme
        ) { oldValue, newValue in
            todoManager.onChangeFilter(prev: oldValue, current: newValue)
        }
        .padding(.horizontal)
    }
    
    var TodoList: some View {
        let filterManager = todoManager.filterManager
        
        return Group {
            switch filterManager.todoFilter {
            case .all:
                List {
                    ForEach(todoManager.todos) { todo in
                        TodoCellView(todo: todo)
                    }
                }
                .listRowSpacing(10)
                .scrollContentBackground(.hidden)
            case .today:
                List {
                    ForEach(todoManager.todayTodos) { todo in
                        TodoCellView(todo: todo)
                    }
                }                
                .listRowSpacing(10)
                .scrollContentBackground(.hidden)
            }
        }
        .animation(.easeInOut, value: todoManager.todos)
        .transition(
            .asymmetric(
                insertion: .move(edge: filterManager.goingRight ? .trailing : .leading),
                removal: .move(edge: filterManager.goingRight ? .leading : .trailing)
            )
        )        
        
    }
}

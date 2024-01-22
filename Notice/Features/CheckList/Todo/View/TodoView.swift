//
//  TodoListView.swift
//  Notice
//
//  Created by 김민성 on 11/6/23.
//

import SwiftUI
import SwiftData

struct TodoView: View {
    @Environment(AppState.self) private var appState
    @EnvironmentObject private var manager: TodoManager
    
    var body: some View {
        VStack {
            TodoFilterPicker
            TodoList
        }
        .sheet(isPresented: $manager.shouldOpenEditor) {
            TodoFormView()
        }
        .onAppear {
            appState.onTapPlusButton = manager.onTapPlusButton
        }
    }
    
    var TodoFilterPicker: some View {
        NTPicker(
            $manager.todoFilter.animation(.easeInOut(duration: 0.2)),
            TodoFilter.allCases,
            theme: appState.theme
        ) { oldValue, newValue in
            manager.setTabDirection(prevTab: oldValue, currentTab: newValue)
        }
        .padding(.horizontal)
    }
    
    var TodoList: some View {
        Group {
            switch manager.todoFilter {
            case .all:
                List {
                    ForEach(manager.todos) { todo in
                        TodoCellView(todo: todo)
                    }
                }
                .listRowSpacing(10)
                .scrollContentBackground(.hidden)
            case .today:
                List {
                    ForEach(manager.todayTodos) { todo in
                        TodoCellView(todo: todo)
                    }
                }                
                .listRowSpacing(10)
                .scrollContentBackground(.hidden)
            }
        }
        .animation(.easeInOut, value: manager.todos)
        .transition(
            .asymmetric(
                insertion: .move(edge: manager.goingRight ? .trailing : .leading),
                removal: .move(edge: manager.goingRight ? .leading : .trailing)
            )
        )        
        
    }
}

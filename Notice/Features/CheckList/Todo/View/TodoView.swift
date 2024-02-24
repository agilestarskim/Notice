//
//  TodoListView.swift
//  Notice
//
//  Created by 김민성 on 11/6/23.
//

import SwiftUI

struct TodoView: View {
    
    enum TodoTab: String, CaseIterable, Identifiable {
        var id: String { self.rawValue }
        case today = "Today"
        case all = "All"
    }
    
    @Environment(AppState.self) private var appState
    @Environment(TodoManager.self) private var todoManager
    @State private var tab: TodoTab = .today
    
    var body: some View {
        @Bindable var editManager = todoManager.editManager
        TabView(selection: $tab) {
            List {
                ForEach(todoManager.todayTodos) { todo in
                    TodoCellView(todo: todo)
                }
            }
            .listRowSpacing(10)
            .scrollContentBackground(.hidden)
            .tag(TodoTab.today)
            
            List {
                ForEach(todoManager.todos) { todo in
                    TodoCellView(todo: todo)
                }
            }
            .listRowSpacing(10)
            .scrollContentBackground(.hidden)
            .tag(TodoTab.all)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .onAppear(perform: todoManager.onAppear)        
        .animation(.easeInOut, value: todoManager.todos)
        .safeAreaInset(edge: .top) {
            NTPicker(tab: $tab)
        }
        .sheet(isPresented: $editManager.shouldOpenEditor) {
            TodoFormView()
        }
    }
}

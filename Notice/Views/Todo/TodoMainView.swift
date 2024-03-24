//
//  TodoListView.swift
//  Notice
//
//  Created by 김민성 on 11/6/23.
//

import SwiftUI

struct TodoMainView: View {
    
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
        NavigationStack {
            List {
                Section {
                    ForEach(todoManager.overdue) { todo in
                        TodoCellView(todo: todo)
                    }
                } header: {
                    Text("지난 일")
                }
                
                Section {
                    ForEach(todoManager.today) { todo in
                        TodoCellView(todo: todo)
                    }
                } header: {
                    Text("오늘 할 일")
                }
                
                Section {
                    ForEach(todoManager.next) { todo in
                        TodoCellView(todo: todo)
                    }
                } header: {
                    Text("다음에 할 일")
                }
            }
            .listStyle(.plain)
            .scrollBounceBehavior(.basedOnSize)
            .scrollContentBackground(.hidden)
            .background(appState.theme.background)
            .onAppear(perform: todoManager.onAppear)
            .sheet(isPresented: $editManager.shouldOpenEditor) {
                TodoFormView()
            }
            .navigationTitle("할 일")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        todoManager.editManager.shouldOpenEditor = true
                    } label: {
                        Text("Add")
                    }
                }
            }
        }
    }
}

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
        List {
            ForEach(manager.todos) { todo in
                TodoCellView(todo: todo)
            }
        }
        .animation(.default, value: manager.todos)
        .listRowSpacing(10)
        .scrollContentBackground(.hidden)
        .safeAreaPadding(.bottom, 70)
        .sheet(isPresented: $manager.shouldOpenEditor) {
            TodoFormView()
        }
        .onAppear {
            appState.onTapPlusButton = manager.onTapPlusButton
        }        
    }
}

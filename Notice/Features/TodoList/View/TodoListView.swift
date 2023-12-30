//
//  TodoListView.swift
//  Notice
//
//  Created by 김민성 on 11/6/23.
//

import SwiftUI
import SwiftData

struct TodoListView: View {
    @Environment(AppState.self) private var appState
    @EnvironmentObject private var vm: TodoViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                FilterPicker
                TodosList
            }
            .background(appState.theme.background)            
        }
        .sheet(isPresented: $vm.isOpenEditorToCreate) {
            TodoFormView()
        }
        .onAppear {
            appState.onTapPlusButton = vm.onTapPlusButton
        }
        .onChange(of: vm.filter) {
            vm.fetchTodos()
        }
    }
    
    var FilterPicker: some View {
        Picker("Filter", selection: $vm.filter) {
            ForEach(Filter.allCases, id: \.self) { filter in
                Text(filter.rawValue)
                    .tag(filter)
            }
        }
        .pickerStyle(.segmented)        
        .colorMultiply(appState.theme.accent)
        .padding(.top)
        .padding(.horizontal)
    }
    
    var TodosList: some View {
        List {
            ForEach(vm.todos) { todo in
                TodoCellView(todo: todo)
            }
        }                
        .animation(.default, value: vm.filter)
        .animation(.default, value: vm.todos)
        .listRowSpacing(10)
        .scrollContentBackground(.hidden)
    }
}

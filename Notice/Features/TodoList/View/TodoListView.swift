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
        VStack(spacing: 0) {
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
            
            List {
                ForEach(vm.todos) { todo in
                    TodoCellView(todo: todo)
                }
            }
            .listRowSpacing(10)
            .scrollContentBackground(.hidden)
        }
        .background(appState.theme.background)
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
}

#Preview {
    TodoListView()
}

//
//  TodoCellView.swift
//  Notice
//
//  Created by 김민성 on 11/13/23.
//

import SwiftUI

struct TodoCellView: View {
    @Environment(AppState.self) private var appState
    @EnvironmentObject private var vm: TodoViewModel
    @State private var isOpenSubTodoToggle: Bool = true
    
    let todo: Todo
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(spacing: 20) {
                TodoDoneButton
                TodoContent
                Spacer()
                SubTodoToggle
            }
            SubTodos
                .padding(.leading, 50)
        }
        .listRowSeparator(.hidden)
        .listRowBackground(appState.theme.container)        
        .sheet(item: $vm.editingTodo) { _ in
            TodoFormView()
        }
        .swipeActions(edge: .leading) {
            Button("Edit") {
                vm.onTapEditButton(todo: self.todo)
            }
            .tint(appState.theme.accent)
        }
        .swipeActions(edge: .trailing) {
            Button("Delete", role: .destructive) {
                vm.delete(self.todo)
            }
        }
    }
    
    private var TodoDoneButton: some View {
        Button {
            vm.toggleDone(todo)
        } label: {
            vm.doneButtonImage(todo.isDone)
                .symbolEffect(.bounce, value: todo.isDone)
                .font(.title)
        }
        .buttonStyle(.plain)
        .foregroundStyle(todo.isDone ? appState.theme.accent : appState.theme.secondary)
    }
    
    @ViewBuilder
    private var TodoContent: some View {
        VStack(alignment: .leading) {
            Text(todo.title)
                .foregroundStyle(appState.theme.primary)
                .fontWeight(.semibold)
            
            if !todo.memo.isEmpty {
                Text(todo.memo)
                    .font(.footnote)
                    .foregroundStyle(appState.theme.secondary)
            }
            
            HStack {
                Text(Format.shared.day(todo.date) + " " + Format.shared.time(todo.date))
                    .foregroundStyle(appState.theme.secondary)
                    .font(.footnote)
                
                if todo.flag {
                    Image(systemName: "flag.fill")
                        .foregroundStyle(appState.theme.accent)
                        .imageScale(.small)
                }
            }
        }
    }
    
    @ViewBuilder
    private var SubTodoToggle: some View {
        if let subTodos = todo.subTodos, !subTodos.isEmpty {
            Button {
                isOpenSubTodoToggle.toggle()
            } label: {
                Image(systemName: "chevron.forward")
                    .rotationEffect(isOpenSubTodoToggle ? .degrees(90) : .zero)
            }
            .tint(appState.theme.secondary)
        }
    }
    
    @ViewBuilder
    private var SubTodos: some View {
        if let subTodos = todo.subTodos, !subTodos.isEmpty, isOpenSubTodoToggle {
            ForEach(subTodos) { subTodo in
                HStack {
                    Button {
                        vm.toggleSubtodoDone(subTodo, of: self.todo)
                    } label: {
                        vm.doneButtonImage(subTodo.isDone)
                    }
                    .buttonStyle(.plain)
                    .foregroundStyle(subTodo.isDone ? appState.theme.accent : appState.theme.secondary)
                    .saturation(0.6)
                    .symbolEffect(.bounce, value: subTodo.isDone)
                    
                    Text(subTodo.title)
                        .foregroundStyle(appState.theme.primary)
                }                
            }            
        }
    }
}

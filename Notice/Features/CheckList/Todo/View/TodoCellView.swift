//
//  TodoCellView.swift
//  Notice
//
//  Created by 김민성 on 11/13/23.
//

import SwiftUI

struct TodoCellView: View {
    @Environment(AppState.self) private var appState
    @Environment(TodoManager.self) private var todoManager
    @State private var isOpenSubTodoToggle: Bool = true
    
    let todo: Todo
    
    var body: some View {
        @Bindable var editManager = todoManager.editManager
        
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
        .sheet(item: $editManager.editingTodo) { _ in
            TodoFormView()
        }
        .swipeActions(edge: .leading) {
            Button("Edit") {
                todoManager.onTapEditButton(todo: self.todo)
            }
            .tint(appState.theme.accent)
        }
        .swipeActions(edge: .trailing) {
            Button("Delete", role: .destructive) {
                todoManager.onTapDeleteButton(todo)
            }
        }        
    }
    
    private var TodoDoneButton: some View {
        Button {            
            todoManager.onTapDoneButton(of: todo)
        } label: {
            Image(systemName: todo.isDone ? "circle.circle.fill" : "circle")
                .symbolEffect(.bounce, value: todo.isDone)
                .font(.title)
        }
        .buttonStyle(.plain)
        .foregroundStyle(todo.isDone ? appState.theme.accent : appState.theme.secondary)
        .id(todo.id)
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
                let formatter = todoManager.formatter
                let dateInfo = formatter.string(todo.date, style: .MdE)
                let timeInfo = formatter.string(todo.date, style: .hmma)
                
                Text(dateInfo + " " + timeInfo)
                    .foregroundStyle(appState.theme.secondary)
                    .font(.footnote)
                
                if todo.flag {
                    Image(systemName: "flag.fill")
                        .foregroundStyle(appState.theme.accent)
                        .imageScale(.small)
                }
                
                let state = todoManager.todoState(todo)
                if state == .today {
                    TodayBadge
                } else if state == .over {
                    OverBadge
                }                
            }
        }
    }
    
    @ViewBuilder
    private var SubTodoToggle: some View {
        if !todo.subTodos.isEmpty {
            Button {
                isOpenSubTodoToggle.toggle()
            } label: {
                Image(systemName: "chevron.forward")
                    .foregroundStyle(appState.theme.secondary)
                    .rotationEffect(isOpenSubTodoToggle ? .degrees(90) : .zero)
            }
            .buttonStyle(.plain)
        }
    }
    
    @ViewBuilder
    private var SubTodos: some View {
        if !todo.subTodos.isEmpty, isOpenSubTodoToggle {
            ForEach(todo.sortedSubTodos) { subTodo in
                HStack {
                    Button {
                        todoManager.onTapDoneButton(subTodo: subTodo, of: todo)
                    } label: {
                        Image(systemName: subTodo.isDone ? "circle.circle.fill" : "circle")                        
                    }
                    .buttonStyle(.plain)
                    .foregroundStyle(subTodo.isDone ? appState.theme.accent : appState.theme.secondary)
                    .symbolEffect(.bounce, value: subTodo.isDone)
                    .id(subTodo.id)
                    
                    Text(subTodo.title)
                        .foregroundStyle(appState.theme.primary)
                }
            }
        }
    }
    
    private var TodayBadge: some View {
        Text("Today")
            .bold()
            .foregroundStyle(.white)
            .font(.caption2)
            .padding(.horizontal, 5)
            .padding(.vertical, 3)
            .background(.blue.opacity(0.3))
            .clipShape(.capsule)
    }
    
    private var OverBadge: some View {
        Text("Over")
            .bold()
            .foregroundStyle(.white)
            .font(.caption2)
            .padding(.horizontal, 5)
            .padding(.vertical, 3)
            .background(.red.opacity(0.3))
            .clipShape(.capsule)
    }
}

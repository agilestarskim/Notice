//
//  TodoAddView.swift
//  Notice
//
//  Created by 김민성 on 11/17/23.
//

import SwiftUI

struct TodoFormView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(AppState.self) private var appState
    @EnvironmentObject private var manager: TodoManager
    
    @State private var title: String = ""
    @State private var memo: String = ""
    @State private var flag: Bool = false
    @State private var date: Date = .now
    @State private var subTodos: [SubTodo] = []
    
    @State private var subTodoTitle: String = ""
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TitleTextField
                    MemoTextField
                    FlagToggle
                    StartDatePicker
                }
                .foregroundStyle(appState.theme.primary)
                .listRowBackground(appState.theme.container.opacity(0.8))
                
                Section {
                    SubTodoTextField
                    SubTodosList
                }
                .foregroundStyle(appState.theme.primary)
                .listRowBackground(appState.theme.container.opacity(0.8))
            }
            .scrollBounceBehavior(.basedOnSize)
            .scrollContentBackground(.hidden)            
            .background(appState.theme.background)
            .listRowSpacing(10)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(manager.editingTodo == nil ? "할 일 추가" : "할 일 편집")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(appState.theme.accent)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("완료", action: done)
                        .tint(appState.theme.accent)
                        .opacity(title.isEmpty ? 0.5 : 1)
                }
            }
        }
        .onAppear(perform: setData)
    }
    
    private var TitleTextField: some View {
        TextField(
            "title",
            text: $title,
            prompt: Text("제목을 입력하세요")
                .foregroundStyle(appState.theme.secondary)
        )
        .autocorrectionDisabled()
    }
    
    private var MemoTextField: some View {
        TextField(
            "memo",
            text: $memo,
            prompt: Text("메모를 입력하세요")
                .foregroundStyle(appState.theme.secondary)
        )
        .autocorrectionDisabled()
    }
    
    private var FlagToggle: some View {
        Toggle("중요", isOn: $flag)
            .tint(appState.theme.accent)
    }
    
    private var StartDatePicker: some View {
        HStack {
            Text("시작일")
            Spacer()
            DatePicker(
                "startDate",
                selection: $date,
                displayedComponents: [.date, .hourAndMinute]
            )
            .labelsHidden()
            .colorInvert()
        }
    }
    
    private var SubTodoTextField: some View {
        HStack {
            TextField(
                "SubTodo",
                text: $subTodoTitle,
                prompt: Text("세부 할 일")
                    .foregroundStyle(appState.theme.secondary)
            )
            
            Button("Add", action: addSubTodo)
                .disabled(subTodoTitle.isEmpty)
                .buttonStyle(.borderedProminent)
                .tint(appState.theme.accent)
        }
    }
    
    private var SubTodosList: some View {
        ForEach(subTodos) { subTodo in
            HStack {
                Text(subTodo.title)
                Spacer()
                Button {
                    removeSubTodo(subTodo: subTodo)
                } label: {
                    Image(systemName: "x.circle.fill")
                }
            }
        }
        .animation(.bouncy, value: subTodos)
    }
    
    private func setData() {
        if let todo = manager.editingTodo, let subTodos = todo.subTodos {
            self.title = todo.title
            self.memo = todo.memo
            self.date = todo.date
            self.flag = todo.flag
            self.subTodos = subTodos
        }
    }
    
    private func addSubTodo() {
        let subTodo = SubTodo(title: self.subTodoTitle, isDone: false)
        self.subTodos.append(subTodo)
        self.subTodoTitle = ""
    }
    
    private func removeSubTodo(subTodo: SubTodo) {
        if let index = self.subTodos.firstIndex(of: subTodo) {
            self.subTodos.remove(at: index)
        }
    }
    
    private func done() {
        if title.isEmpty { return }
        
        let newTodo = Todo(title: title, memo: memo, date: date, flag: flag, subTodos: subTodos)
        
        if manager.editingTodo == nil {
            manager.create(newTodo)
        } else {
            manager.update(newTodo)
        }
        dismiss()        
    }
}

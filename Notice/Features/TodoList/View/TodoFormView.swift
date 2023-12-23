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
    @EnvironmentObject private var vm: TodoViewModel
    
    
    @State private var title: String
    @State private var memo: String
    @State private var flag: Bool
    @State private var date: Date
    @State private var subTodos: [SubTodo] = []
    let todo: Todo?
    
    init(todo: Todo? = nil) {
        self.todo = todo
        
        self._title = State(initialValue: todo?.title ?? "")
        self._memo = State(initialValue: todo?.memo ?? "")
        self._flag = State(initialValue: todo?.flag ?? false)
        self._date = State(initialValue: todo?.date ?? .now)
    }
    
    var body: some View {
        NavigationStack {
            List {
                Group {
                    TitleTextField
                    MemoTextField
                    FlagToggle
                    StartDatePicker
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
                    Text("할 일 추가")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(appState.theme.accent)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("완료", action: done)
                        .tint(appState.theme.accent)
                }
            }
        }
    }
    
    var TitleTextField: some View {
        TextField(
            "title",
            text: $title,
            prompt: Text("제목을 입력하세요")
                .foregroundStyle(appState.theme.secondary)
        )
        .autocorrectionDisabled()
    }
    
    var MemoTextField: some View {
        TextField(
            "memo",
            text: $memo,
            prompt: Text("메모를 입력하세요")
                .foregroundStyle(appState.theme.secondary)
        )
        .autocorrectionDisabled()
    }
    
    var FlagToggle: some View {
        Toggle("중요", isOn: $flag)
            .tint(appState.theme.accent)
    }
    
    var StartDatePicker: some View {
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
    
    func done() {
        let newTodo = Todo(title: title, memo: memo, date: date, flag: flag, subTodos: subTodos)
        if let todo = self.todo {
            vm.update(origin: todo, edit: newTodo)
        } else {
            vm.create(newTodo)
        }
        dismiss()
    }
}

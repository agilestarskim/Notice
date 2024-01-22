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
    @Environment(TodoManager.self) private var todoManager
    
    var body: some View {
        let editManager = todoManager.editManager
        
        FormContainer(
            title: editManager.formTitle,
            theme: appState.theme,
            button: {
                Button("완료") {
                    todoManager.onTapEditDoneButton()
                    dismiss()
                }
                .tint(appState.theme.accent)
                .disabled(editManager.isTitleEmpty)
            },
            content: {
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
                .listRowSpacing(10)
            }
        )
    }
    
    private var TitleTextField: some View {
        @Bindable var editManager = todoManager.editManager
        
        return TextField(
            "title",
            text: $editManager.title,
            prompt: Text("제목을 입력하세요")
                .foregroundStyle(appState.theme.secondary)
        )
        .autocorrectionDisabled()
    }
    
    private var MemoTextField: some View {
        @Bindable var editManager = todoManager.editManager
        
        return TextField(
            "memo",
            text: $editManager.memo,
            prompt: Text("메모를 입력하세요")
                .foregroundStyle(appState.theme.secondary)
        )
        .autocorrectionDisabled()
    }
    
    private var FlagToggle: some View {
        @Bindable var editManager = todoManager.editManager
        
        return Toggle("중요", isOn: $editManager.flag)
            .tint(appState.theme.accent)
    }
    
    private var StartDatePicker: some View {
        @Bindable var editManager = todoManager.editManager
        
        return HStack {
            Text("시작일")
            Spacer()
            DatePicker(
                "startDate",
                selection: $editManager.date,
                displayedComponents: [.date, .hourAndMinute]
            )
            .labelsHidden()
            .colorInvert()
        }
    }
    
    private var SubTodoTextField: some View {
        @Bindable var editManager = todoManager.editManager
        return HStack {
            TextField(
                "SubTodo",
                text: $editManager.subTodoTitle,
                prompt: Text("세부 할 일")
                    .foregroundStyle(appState.theme.secondary)
            )
            
            Button("Add", action: editManager.addSubTodo)
                .disabled(editManager.subTodoTitle.isEmpty)
                .buttonStyle(.borderedProminent)
                .tint(appState.theme.accent)
        }
    }
    
    private var SubTodosList: some View {
        let editManger = todoManager.editManager
        
        return ForEach(editManger.subTodos) { subTodo in
            HStack {
                Text(subTodo.title)
                Spacer()
                Button {
                    editManger.deleteSubTodo(subTodo: subTodo)
                } label: {
                    Image(systemName: "x.circle.fill")
                }
            }
        }        
    }
}

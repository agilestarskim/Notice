//
//  RoutineFormView.swift
//  Notice
//
//  Created by 김민성 on 1/8/24.
//

import SwiftUI

struct RoutineFormView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(AppState.self) private var appState
    @Environment(RoutineManager.self) private var routineManager
    
    var body: some View {
        @Bindable var editManager = routineManager.editManager
        
        FormContainer(
            title: editManager.formContainerTitle,
            theme: appState.theme,
            button: {
                Button("완료") {
                    routineManager.onTapEditDoneButton()
                    dismiss()
                }
                .tint(appState.theme.accent)
                .disabled(editManager.isTitleEmpty)
            },
            content: {
                List {
                    Section{
                        TitleTextField
                        CellColorPicker
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
        @Bindable var editManager = routineManager.editManager
        return TextField(
            "title",
            text: $editManager.title,
            prompt: Text("제목을 입력하세요")
                .foregroundStyle(appState.theme.secondary)
        )
        .autocorrectionDisabled()
    }
    
    private var CellColorPicker: some View {
        @Bindable var editManager = routineManager.editManager
        return NTColorPicker(color: $editManager.color)
    }    
}

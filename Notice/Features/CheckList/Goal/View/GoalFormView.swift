//
//  GoalFormView.swift
//  Notice
//
//  Created by 김민성 on 1/2/24.
//

import SwiftUI

struct GoalFormView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(AppState.self) private var appState
    @Environment(GoalManager.self) private var goalManager

    var body: some View {
        @Bindable var editManager = goalManager.editManager
        FormContainer(
            title: editManager.formTitle,
            theme: appState.theme,
            button: {
                Button("완료"){
                    goalManager.onTapEditDoneButton()
                    dismiss()
                }
                .tint(appState.theme.accent)
                .disabled(editManager.isTitleEmpty)
            },
            content: {                
                Section {
                    TitleTextField
                    StartDatePicker
                    DurationPicker
                    EndDatePicker
                    NTEmojiPicker(emoji: $editManager.emoji, selectColor: appState.theme.primary)
                }
                .foregroundStyle(appState.theme.primary)
                .listRowBackground(appState.theme.container.opacity(0.8))
            }
        )
        .onAppear(perform:editManager.setData)
        .onChange(of: editManager.startDate, editManager.setEndDate)
        .onChange(of: editManager.duration, editManager.setEndDate)
    }
    
    private var TitleTextField: some View {
        @Bindable var editManager = goalManager.editManager
        return TextField(
            "title",
            text: $editManager.title,
            prompt: Text("제목을 입력하세요")
                .foregroundStyle(appState.theme.secondary)
        )
        .autocorrectionDisabled()
    }
    
    @ViewBuilder
    var StartDatePicker: some View {
        @Bindable var editManager = goalManager.editManager
        HStack {
            Text("시작일")
            Spacer()
            switch editManager.editState {
            case .create:
                DatePicker(
                    "startDate",
                    selection: $editManager.startDate,
                    in: .now...,
                    displayedComponents: [.date]
                )
                .labelsHidden()
                .colorInvert()
            case .edit:
                Text(NTFormatter.shared.string(editManager.startDate, style: .yyyyMMdd))
            case .retry:
                DatePicker(
                    "startDate",
                    selection: $editManager.startDate,
                    in: .now...,
                    displayedComponents: [.date]
                )
                .labelsHidden()
                .colorInvert()
            }
        }
    }
    
    @ViewBuilder
    var DurationPicker: some View {
        @Bindable var editManager = goalManager.editManager
        let editState = editManager.editState
        if editState == .create || editState == .retry {
            Picker("목표기간", selection: $editManager.duration) {
                ForEach(GoalDuration.allCases, id: \.rawValue) { duration in
                    Text(duration.title)
                        .tag(duration)
                        .foregroundStyle(appState.theme.secondary)
                }
            }
            .tint(appState.theme.accent)
        }        
    }
    
    @ViewBuilder
    var EndDatePicker: some View {
        @Bindable var editManager = goalManager.editManager
        let editState = editManager.editState
        HStack {
            Text("종료일")
            Spacer()
            if editManager.duration == .custom && (editState == .create || editState == .retry) {
                DatePicker(
                    "endDate",
                    selection: $editManager.endDate,
                    in: editManager.startDate...,
                    displayedComponents: [.date]
                )
                .labelsHidden()
                .colorInvert()
            } else {
                if editManager.state == 1 {
                    Text(NTFormatter.shared.string(editManager.editingGoal?.realEndDate ?? .now, style: .yyyyMMdd))
                } else {
                    Text(NTFormatter.shared.string(editManager.endDate, style: .yyyyMMdd))
                }
                
            }
        }
    }
}

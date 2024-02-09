//
//  CalendarFormView.swift
//  Notice
//
//  Created by 김민성 on 11/23/23.
//

import SwiftData
import SwiftUI

struct CalendarFormView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(AppState.self) private var appState
    @Environment(CalendarManager.self) private var calendarManager
    
    var body: some View {
        let editor = calendarManager.editManager
        FormContainer(
            title: editor.editingEvent == nil ? "이벤트 추가" : "이벤트 편집",
            theme: appState.theme,
            button: {
                Button("완료") {
                    calendarManager.onTapEditEventDoneButton()
                    dismiss()
                }
                .tint(appState.theme.accent)
                .opacity(editor.title.isEmpty ? 0.5 : 1)
            },
            content: {
                List {
                    Group {
                        TitleTextField
                        MemoTextField
                        CategoryPicker
                        StartDatePicker
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
    
    var TitleTextField: some View {
        @Bindable var editor = calendarManager.editManager
        return TextField(
            "title",
            text: $editor.title,
            prompt: Text("제목을 입력하세요 (필수)")
                .foregroundStyle(appState.theme.secondary)
        )
        .autocorrectionDisabled()
    }
    
    var MemoTextField: some View {
        @Bindable var editor = calendarManager.editManager
        return TextField(
            "memo",
            text: $editor.memo,
            prompt: Text("메모를 입력하세요 (선택)")
                .foregroundStyle(appState.theme.secondary)
        )
        .autocorrectionDisabled()
    }
    
    var CategoryPicker: some View {
        @Bindable var editor = calendarManager.editManager
        return Picker("카테고리", selection: $editor.category) {
            ForEach(EventCategory.allCases, id: \.rawValue) { category in
                Text(category.rawValue)
                    .tag(category.rawValue)
                    .foregroundStyle(appState.theme.secondary)
            }
        }
        .tint(appState.theme.accent)
    }
    
    var StartDatePicker: some View {
        @Bindable var editor = calendarManager.editManager
        return HStack {
            Text("시작일")
            Spacer()
            DatePicker(
                "startDate",
                selection: $editor.startDate,
                displayedComponents: [.date, .hourAndMinute]
            )
            .labelsHidden()
            .colorInvert()
        }
    }
}

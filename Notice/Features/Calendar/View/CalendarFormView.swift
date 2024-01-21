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
    @EnvironmentObject private var vm: CalendarViewModel
    
    @State private var title: String = ""
    @State private var memo: String = ""
    @State private var category: String = EventCategory.meeting.rawValue
    @State private var startDate: Date = .now
    
    var body: some View {
        FormContainer(
            title: vm.editingEvent == nil ? "이벤트 추가" : "이벤트 편집",
            theme: appState.theme,
            button: {
                Button("완료", action: done)
                    .tint(appState.theme.accent)
                    .opacity(title.isEmpty ? 0.5 : 1)
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
        .onAppear(perform: setData)
    }
    
    var TitleTextField: some View {
        TextField(
            "title",
            text: $title,
            prompt: Text("제목을 입력하세요 (필수)")
                .foregroundStyle(appState.theme.secondary)
        )
        .autocorrectionDisabled()
    }
    
    var MemoTextField: some View {
        TextField(
            "memo",
            text: $memo,
            prompt: Text("메모를 입력하세요 (선택)")
                .foregroundStyle(appState.theme.secondary)
        )
        .autocorrectionDisabled()
    }
    
    var CategoryPicker: some View {
        Picker("카테고리", selection: $category) {
            ForEach(EventCategory.allCases, id: \.rawValue) { category in
                Text(category.rawValue)
                    .tag(category.rawValue)
                    .foregroundStyle(appState.theme.secondary)
            }
        }
        .tint(appState.theme.accent)
    }
    
    var StartDatePicker: some View {
        HStack {
            Text("시작일")
            Spacer()
            DatePicker(
                "startDate",
                selection: $startDate,
                displayedComponents: [.date, .hourAndMinute]
            )
            .labelsHidden()
            .colorInvert()
        }
    }
    
    private func setData() {
        if let event = vm.editingEvent {
            self.title = event.title
            self.memo = event.memo
            self.category = event.category
            self.startDate = event.startDate
        } else {
            self.startDate = vm.selectedDate
        }
    }
    
    
    func done() {
        if title.isEmpty { return }
        let newEvent = Event(title: title, memo: memo, category: category, startDate: startDate)
        if vm.editingEvent == nil {
            vm.create(newEvent)            
        } else {
            vm.update(newEvent)
        }
        dismiss()
    }
}

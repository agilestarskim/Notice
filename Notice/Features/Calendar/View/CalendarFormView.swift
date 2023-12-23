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
    
    @State private var title: String
    @State private var memo: String
    @State private var category: String
    @State private var startDate: Date
    
    private let event: Event?
    
    init(event: Event? = nil, defaultStartDate: Date) {
        self.event = event
        self._title = State(initialValue: event?.title ?? "")
        self._memo = State(initialValue: event?.memo ?? "")
        self._category = State(initialValue: event?.category ?? EventCategory.meeting.rawValue)
        self._startDate = State(initialValue: event?.startDate ?? defaultStartDate)
    }
    
    var body: some View {
        NavigationStack {
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
            .background(appState.theme.background)
            .listRowSpacing(10)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("이벤트 추가")
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
    
    
    
    func done() {
        let newEvent = Event(title: title, memo: memo, category: category, startDate: startDate)
        if let event = self.event {
            vm.update(origin: event, edit: newEvent)
        } else {
            vm.create(newEvent)
        }
        dismiss()
    }
}

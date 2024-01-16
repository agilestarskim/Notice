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
    @EnvironmentObject private var manager: GoalManager
    
    @State private var title: String = ""
    @State private var startDate: Date = .now
    @State private var endDate: Date = .now
    @State private var duration: GoalDuration = .week
    @State private var image: Data? = nil
    @State private var state: Int = 0
    

    var body: some View {
        NavigationStack {
            List {
                Section {
                    TitleTextField
                    StartDatePicker
                    DurationPicker
                    EndDatePicker
                }
                .foregroundStyle(appState.theme.primary)
                .listRowBackground(appState.theme.container.opacity(0.8))
                
                Section {
                   
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
                    Group {
                        switch manager.editState(state) {
                        case .create:
                            Text("목표 추가")
                        case .edit:
                            Text("목표 편집")
                        case .retry:
                            Text("목표 재도전")
                        }
                    }
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
        .onChange(of: startDate, setEndDate)
        .onChange(of: duration, setEndDate)
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
    
    @ViewBuilder
    var StartDatePicker: some View {
        HStack {
            Text("시작일")
            Spacer()
            switch manager.editState(state) {
            case .create:
                DatePicker(
                    "startDate",
                    selection: $startDate,
                    in: .now...,
                    displayedComponents: [.date]
                )
                .labelsHidden()
                .colorInvert()
            case .edit:
                Text(DateFormatter.string(startDate, style: .yyyyMMdd))
            case .retry:
                DatePicker(
                    "startDate",
                    selection: $startDate,
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
        let editState = manager.editState(state)
        if editState == .create || editState == .retry {
            Picker("목표기간", selection: $duration) {
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
        HStack {
            Text("종료일")
            Spacer()
            let editState = manager.editState(state)
            if duration == .custom && (editState == .create || editState == .retry) {
                DatePicker(
                    "endDate",
                    selection: $endDate,
                    in: startDate...,
                    displayedComponents: [.date]
                )
                .labelsHidden()
                .colorInvert()
            } else {
                Text(DateFormatter.string(endDate, style: .yyyyMMdd))
            }
        }
    }
    
    private func done() {
        if title.isEmpty { return }
        
        let newGoal = Goal(
            title: title,
            startDate: startDate,
            endDate: endDate,
            duration: duration.rawValue,
            image: image,
            state: state
        )
        
        if manager.editingGoal == nil {
            manager.create(newGoal)
        } else {
            manager.update(newGoal)
        }
        dismiss()
    }
    
    private func setEndDate() {
        if let endDate = manager.calculateEndDate(duration, after: startDate) {
            self.endDate = endDate
        }
    }
    
    private func setData() {
        let state = manager.editingGoal?.state ?? 0
        switch manager.editState(state) {
        case .create:
            break
        case .edit:
            if let goal = manager.editingGoal{
                self.title = goal.title
                self.duration = GoalDuration(rawValue: goal.duration) ?? .week
                self.startDate = goal.startDate
                self.endDate = goal.endDate
                self.state = goal.state
                self.image = goal.image
            }
        case .retry:
            if let goal = manager.editingGoal{
                self.title = goal.title
                self.duration = .week
                self.state = goal.state
                self.image = goal.image
            }
        }
        setEndDate()
    }
}

#Preview {
    GoalFormView()
}

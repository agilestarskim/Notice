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
    @EnvironmentObject private var vm: GoalViewModel
    
    @State private var title: String = ""
    @State private var memo: String = ""
    @State private var startDate: Date = .now
    @State private var endDate: Date = .now
    @State private var duration: GoalDuration = .week
    @State private var image: Data? = nil
    

    var body: some View {
        NavigationStack {
            List {
                Section {
                    TitleTextField
                    MemoTextField
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
                    Text("목표 추가")
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
        .onChange(of: duration) { oldValue, newValue in
            if oldValue == .forever && newValue == .custom {
                setCustomEndDateFromForever()
            } else {
                setEndDate()
            }
        }
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
    
    @ViewBuilder
    var StartDatePicker: some View {
        HStack {
            Text("시작일")
            Spacer()
            if let goal = vm.editingGoal {
                Text(DateFormatter.string(goal.startDate, style: .yyyyMMdd))
            } else {
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
        if vm.editingGoal == nil {
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
            if let goal = vm.editingGoal {
                Text(DateFormatter.string(goal.endDate, style: .yyyyMMdd))
            } else if duration == .custom {
                DatePicker(
                    "endDate",
                    selection: $endDate,
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
        
        let newGoal = Goal(title: title, memo: memo, startDate: startDate, endDate: endDate, duration: duration.rawValue, image: image, state: 0)
        
        if vm.editingGoal == nil {
            vm.create(newGoal)
        } else {
            vm.update(newGoal)
        }
        dismiss()
    }
    
    /* Forever에서 Custom으로 변경 시 DatePicker가 4000년이 세팅되는 것을 방지 */
    private func setCustomEndDateFromForever() {
        if let endDate = vm.calculateEndDate(.week, after: startDate) {
            self.endDate = endDate
        }
    }
    
    private func setEndDate() {
        if let endDate = vm.calculateEndDate(duration, after: startDate) {
            self.endDate = endDate
        }
    }
    
    private func setData() {
        if let goal = vm.editingGoal {
            self.title = goal.title
            self.memo = goal.memo
            self.startDate = goal.startDate
            self.endDate = goal.endDate
            self.duration = GoalDuration(rawValue: goal.duration) ?? .week
            self.image = goal.image
        } else {
            setEndDate()
        }
    }
}

#Preview {
    GoalFormView()
}

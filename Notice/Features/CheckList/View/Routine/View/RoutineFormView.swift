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
    @EnvironmentObject private var manager: RoutineManager
    
    @State private var title: String = ""
    @State private var startDate: Date = .now
    @State private var color: Color = .red
    
    var body: some View {
        FormContainer(
            title: manager.editingRoutine == nil ? "루틴 추가" : "루틴 편집",
            theme: appState.theme,
            button: {
                Button("완료", action: done)
                    .tint(appState.theme.accent)
                    .opacity(title.isEmpty ? 0.5 : 1)
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
    
    private var CellColorPicker: some View {
        NTColorPicker(color: $color)
    }
    
    private func setData() {
        if let routine = manager.editingRoutine {
            self.title = routine.title
            self.startDate = routine.startDate
            self.color = routine.color.toColor
        }
    }
    
    private func done() {
        if self.title.isEmpty { return }
        let performedDates = manager.editingRoutine?.performedDates ?? []
        let newRoutine = Routine(
            title: self.title,
            startDate: self.startDate,
            color: self.color.description,
            performedDates: performedDates
        )
        
        if manager.editingRoutine == nil {
            manager.create(newRoutine)
        } else {
            manager.update(newRoutine)
        }
        dismiss()
    }
}

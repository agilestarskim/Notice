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
    @State private var color: Color = .green
    
    var body: some View {
        NavigationStack {
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
            .background(appState.theme.background)
            .listRowSpacing(10)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("루틴 추가")
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
        ColorPicker("Color", selection: $color, supportsOpacity: false)        
    }
    
    private func setData() {
        if let routine = manager.editingRoutine {
            self.title = routine.title
        }
    }
    
    private func done() {
        if title.isEmpty { return }
        
        let newRoutine = Routine(title: title, startDate: .now, performedDates: [])
        
        if manager.editingRoutine == nil {
            manager.create(newRoutine)
        } else {
            manager.update(newRoutine)
        }
        dismiss()
    }
}

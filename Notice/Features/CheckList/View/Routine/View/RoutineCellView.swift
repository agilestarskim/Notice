//
//  RoutineCellView.swift
//  Notice
//
//  Created by 김민성 on 1/8/24.
//

import SwiftUI

struct RoutineCellView: View {
    @Environment(AppState.self) private var appState
    @EnvironmentObject private var manager: RoutineManager
    
    @State private var isChecked = false
    let routine: Routine
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text(routine.title)
                        .foregroundStyle(appState.theme.primary)
                        .fontWeight(.semibold)
                    
                    HStack {
                        Text("루틴 시작: \(DateFormatter.string(routine.startDate, style: .yyyyMMdd))")
                            .font(.footnote)
                            .foregroundStyle(appState.theme.secondary)
                        Text("\(manager.getDay(from: routine.startDate))일차")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundStyle(appState.theme.primary)
                    }
                }
                
                Spacer()
                
                Button {
                    if !isChecked {
                        doneEffect()
                        manager.toggleDone(routine)
                    }
                } label: {
                    manager.doneButtonImage(isChecked: isChecked)
                        .symbolEffect(.bounce, value: isChecked)
                        .font(.title)
                }
                .buttonStyle(.plain)
                .foregroundStyle(isChecked ? appState.theme.accent : appState.theme.secondary)
                .id(routine.id)                
            }
            GrassView(performedDates, row: 4, col: 15, cellColor: manager.getColor(colorDescription: routine.color))
        }
        .listRowSeparator(.hidden)
        .listRowBackground(appState.theme.container)
        .sheet(item: $manager.editingRoutine) { _ in
            RoutineFormView()
        }
        .swipeActions(edge: .leading) {
            Button("Edit") {
                manager.onTapEditButton(routine: self.routine)
            }
            .tint(appState.theme.accent)
        }
        .swipeActions(edge: .trailing) {
            Button("Delete", role: .destructive) {
                manager.delete(self.routine)
            }
        }
    }
    
    var performedDates: [String] {
        if let performedDates = routine.performedDates {
            return performedDates.map { $0.date }
        } else {
            return []
        }
    }
    
    func doneEffect() {
        isChecked.toggle()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isChecked.toggle()
        }
    }
}

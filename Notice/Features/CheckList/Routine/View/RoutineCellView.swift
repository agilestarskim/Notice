//
//  RoutineCellView.swift
//  Notice
//
//  Created by 김민성 on 1/8/24.
//

import SwiftUI

struct RoutineCellView: View {
    @Environment(AppState.self) private var appState
    @Environment(RoutineManager.self) private var routineManager
    
    @State private var isChecked = false
    @State private var shouldGrassExtend = false
    @State private var shouldDialogOpen = false
    
    let routine: Routine
    
    var body: some View {
        @Bindable var editManager = routineManager.editManager
        
        VStack(spacing: 10) {
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text(routine.title)
                        .foregroundStyle(appState.theme.primary)
                        .fontWeight(.semibold)
                    
                    HStack {
                        Text("루틴 시작: \(NTFormatter.shared.string(routine.startDate, style: .yyyyMMdd))")
                            .font(.footnote)
                            .foregroundStyle(appState.theme.secondary)
                        Text("\(routineManager.getDay(from: routine.startDate))일차")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundStyle(appState.theme.primary)
                    }
                }
                
                Spacer()
                
                Button {
                    if !isChecked {
                        doneEffect()
                        routineManager.onTapDoneButton(of: routine)                        
                    }
                } label: {
                    Image(systemName: isChecked ? "circle.circle.fill" : "circle")
                        .symbolEffect(.bounce, value: isChecked)
                        .font(.title)
                }
                .buttonStyle(.plain)
                .foregroundStyle(isChecked ? routine.color.toColor : appState.theme.secondary)
                .id(routine.id)
            }
            
            VStack {
                GrassViewComponent
            }
            .onTapGesture {
                shouldGrassExtend.toggle()
            }
        }
        .confirmationDialog("삭제하시겠습니까?", isPresented: $shouldDialogOpen) {
            Button("Delete", role: .destructive) {
                routineManager.onTapDeleteButton(routine)
            }
        }
        .listRowSeparator(.hidden)
        .listRowBackground(appState.theme.container)
        .sheet(item: $editManager.editingRoutine) { _ in
            RoutineFormView()
        }
        .swipeActions(edge: .leading) {
            Button("Edit") {
                routineManager.onTapEditButton(routine: routine)
            }
            .tint(appState.theme.accent)
        }
        .swipeActions(edge: .trailing) {
            Button("Delete") {
                shouldDialogOpen = true
            }
            .tint(.red)
        }
    }
    
    @ViewBuilder
    var GrassViewComponent: some View {
        if shouldGrassExtend {
            GrassView(
                routineManager.getPerformedDates(of: routine),
                row: 8,
                col: 20,
                cellColor: routine.color.toColor
            )
        } else {
            GrassView(
                routineManager.getPerformedDates(of: routine),
                row: 4,
                col: 15,
                cellColor: routine.color.toColor
            )
        }
    }
    
    func doneEffect() {
        isChecked.toggle()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isChecked.toggle()
        }
    }
}

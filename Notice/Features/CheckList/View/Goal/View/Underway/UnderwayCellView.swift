//
//  UnderwayCellView.swift
//  Notice
//
//  Created by 김민성 on 1/14/24.
//

import SwiftUI

struct UnderwayCellView: View {
    @Environment(AppState.self) private var appState
    @EnvironmentObject private var manager: GoalManager
    
    @State private var shouldDeleteDialogOpen = false
    @State private var shouldFailureDialogOpen = false
    @State private var shouldSuccessDialogOpen = false
    let goal: Goal
    
    
    var body: some View {
        VStack(spacing: 20) {
            GoalContent
            DecisionButtons
        }
        .confirmationDialog("삭제하시겠습니까?", isPresented: $shouldDeleteDialogOpen) {
            Button("Delete", role: .destructive) {
                withAnimation {
                    manager.delete(goal)
                }
            }
        }
        .listRowBackground(appState.theme.container)
        .swipeActions(edge: .leading) {
            Button("Edit") {
                manager.onTapEditButton(goal: self.goal)
            }
            .tint(appState.theme.accent)
        }
        .swipeActions(edge: .trailing) {
            Button("Delete") {
                shouldDeleteDialogOpen = true                
            }
            .tint(.red)
        }
    }
    
    var GoalContent: some View {
        HStack(spacing: 20) {
            Text(goal.emoji.emoji)
                .font(.largeTitle)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(goal.title)
                    .font(.title3)
                    .bold()
                    .foregroundStyle(appState.theme.primary)
                
                HStack {
                    Text(DateFormatter.string(goal.startDate, style: .yyyyMd))
                    Text("~")
                    Text(DateFormatter.string(goal.endDate, style: .yyyyMd))
                }
                .font(.callout)
                .foregroundStyle(appState.theme.secondary)
            
                
                if let deadline = manager.deadline(goal) {
                    HStack {
                        Text("종료까지")
                        Text("\(deadline)일")
                            .foregroundStyle(appState.theme.primary)
                        Text("남았습니다.")
                    }
                    .font(.callout)
                    .foregroundStyle(appState.theme.secondary)
                } else {
                    Text("종료되었습니다.")
                        .font(.callout)
                        .foregroundStyle(appState.theme.secondary)
                }                
            }
            Spacer()
        }
    }
    
    var DecisionButtons: some View {
        HStack(spacing: 10) {
            Button {
                shouldFailureDialogOpen = true
            } label: {
                Text("Failure")
                    .font(.caption)
                    .frame(maxWidth: .infinity)
            }
            .tint(.red)
            .buttonStyle(.bordered)
            .confirmationDialog("실패하셨습니까?", isPresented: $shouldFailureDialogOpen) {
                Button("Failure") {
                    withAnimation {
                        goal.state = 2
                    }
                }
                .tint(.red)
            }
            
            Button {
                shouldSuccessDialogOpen = true
            } label: {
                Text("Success")
                    .font(.caption)
                    .frame(maxWidth: .infinity)
            }
            .tint(.green)
            .buttonStyle(.bordered)
            .confirmationDialog("성공하셨습니까?", isPresented: $shouldSuccessDialogOpen) {
                Button("Success") {
                    withAnimation {
                        goal.state = 1
                        goal.realEndDate = .now
                    }
                }
                .tint(.red)
            }
        }
    }
}

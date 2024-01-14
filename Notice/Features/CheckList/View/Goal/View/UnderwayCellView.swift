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
    let goal: Goal
    
    var body: some View {
        VStack(spacing: 20) {
            GoalContent
            DecisionButtons
        }
        .listRowBackground(appState.theme.container)
    }
    
    var GoalContent: some View {
        HStack(spacing: 20) {
            Text("🏆")
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
                goal.state = 2
            } label: {
                Text("Failure")
                    .font(.caption)
                    .frame(maxWidth: .infinity)
            }
            .tint(.red)
            .buttonStyle(.bordered)
            
            Button {
                goal.state = 1
            } label: {
                Text("Success")
                    .font(.caption)
                    .frame(maxWidth: .infinity)
            }
            .tint(.green)
            .buttonStyle(.bordered)
        }        
    }
}

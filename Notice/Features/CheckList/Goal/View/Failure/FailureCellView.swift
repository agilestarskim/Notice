//
//  FailureCellView.swift
//  Notice
//
//  Created by 김민성 on 1/15/24.
//

import SwiftUI

struct FailureCellView: View {
    @Environment(AppState.self) private var appState
    @EnvironmentObject private var manager: GoalManager
    
    @State private var shouldDeleteDialogOpen = false
    
    let goal: Goal
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(spacing: 20) {
                Text(goal.emoji.emoji)
                    .font(.largeTitle)
                Text(goal.title)
                    .font(.title3)
                    .bold()
                    .foregroundStyle(appState.theme.primary)
                    .lineLimit(2)
                    .minimumScaleFactor(0.8)
                
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "circle.fill")
                            .resizable()
                            .frame(width: 8, height: 8)
                        Text(NTFormatter.shared.string(goal.startDate, style: .yyyyMd))
                    }
                    
                    HStack {
                        Image(systemName: "circle.fill")
                            .resizable()
                            .frame(width: 8, height: 8)
                        Text(NTFormatter.shared.string(goal.endDate, style: .yyyyMd))
                    }
                }
                .font(.callout)
                .foregroundStyle(appState.theme.secondary)
                
                Button {                    
                    manager.onTapEditButton(goal: goal)
                } label: {
                    Text("Retry")
                        .frame(maxWidth: .infinity)
                }
                .tint(appState.theme.accent)
                .buttonStyle(.bordered)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            Menu {
                Button("Delete") {
                    shouldDeleteDialogOpen = true
                }
            } label: {
                Image(systemName: "ellipsis")
                    .foregroundStyle(appState.theme.secondary)
                    .padding()
                    .contentShape(Rectangle())
            }
            .confirmationDialog("삭제하시겠습니까?", isPresented: $shouldDeleteDialogOpen) {
                Button("Delete", role: .destructive) {
                    manager.delete(goal)
                    appState.showToast("삭제되었습니다")
                }
            }
        }
        .frame(height: 240)
        .background(appState.theme.container)
        .clipShape(.rect(cornerRadius: 12))
    }
}

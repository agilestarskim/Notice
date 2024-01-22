//
//  SuccessCellView.swift
//  Notice
//
//  Created by 김민성 on 1/15/24.
//

import SwiftUI

struct SuccessCellView: View {
    @Environment(AppState.self) private var appState
    @EnvironmentObject private var manager: GoalManager
    @State private var shouldDeleteDialogOpen = false
    @State private var shouldCancelSuccesDialogOpen = false
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
                        Text(DateFormatter.string(goal.startDate, style: .yyyyMd))
                    }
                    .confirmationDialog("삭제하시겠습니까?", isPresented: $shouldDeleteDialogOpen) {
                        Button("Delete", role: .destructive) {
                            manager.delete(goal)
                            appState.showToast("삭제되었습니다")
                        }
                    }
                    
                    HStack {
                        Image(systemName: "circle.fill")
                            .resizable()
                            .frame(width: 8, height: 8)
                        Text(DateFormatter.string(goal.realEndDate, style: .yyyyMd))
                    }
                    .confirmationDialog("성공을 취소하시겠습니까?", isPresented: $shouldCancelSuccesDialogOpen) {
                        Button("Cancel Success") {
                            withAnimation {
                                goal.state = 0
                            }
                        }
                    }
                }
                .font(.callout)
                .foregroundStyle(appState.theme.secondary)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            Menu {
                Button("Edit") {                    
                    manager.onTapEditButton(goal: goal)
                }
                Button("Delete") {
                    shouldDeleteDialogOpen = true
                }
                
                
                Button("Cancel Success") {
                    shouldCancelSuccesDialogOpen = true
                }
            } label: {
                Image(systemName: "ellipsis")
                    .foregroundStyle(appState.theme.secondary)
                    .padding()
                    .contentShape(Rectangle())
            }
        }
        .frame(height: 220)
        .background(appState.theme.container)
        .clipShape(.rect(cornerRadius: 12))
    }
}

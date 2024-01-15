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
    let goal: Goal
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            
            VStack(spacing: 20) {
                Text("🏆")
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
                    
                    HStack {
                        Image(systemName: "circle.fill")
                            .resizable()
                            .frame(width: 8, height: 8)
                        Text(DateFormatter.string(goal.endDate, style: .yyyyMd))
                    }
                }
                .font(.callout)
                .foregroundStyle(appState.theme.secondary)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            Menu {
                Button("Edit") {}
                Button("Delete") {}
            } label: {
                Image(systemName: "ellipsis")
                    .foregroundStyle(appState.theme.primary)
                    .padding()
                    .contentShape(Rectangle())
            }
        }
        .frame(height: 220)
        .background(appState.theme.container)
        .clipShape(.rect(cornerRadius: 12))
    }
}

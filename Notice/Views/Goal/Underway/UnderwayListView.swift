//
//  UnderwayListView.swift
//  Notice
//
//  Created by 김민성 on 1/14/24.
//

import SwiftUI

struct UnderwayListView: View {    
    @Environment(AppState.self) private var appState
    @Environment(GoalManager.self) private var goalManager
    
    var body: some View {
        List {
            if goalManager.underways.isEmpty {
                Text("목표가 없습니다")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
                    .font(.title3)
                    .foregroundStyle(appState.theme.primary)
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
            } else {
                ForEach(goalManager.underways) { goal in
                    UnderwayCellView(goal: goal)
                }
            }
            
        }        
        .animation(.default, value: goalManager.underways)
        .listRowSpacing(10)
        .scrollContentBackground(.hidden)
    }
}

#Preview {
    UnderwayListView()
}

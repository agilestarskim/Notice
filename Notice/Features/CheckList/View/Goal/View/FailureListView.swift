//
//  FailureListView.swift
//  Notice
//
//  Created by 김민성 on 1/14/24.
//

import SwiftUI

struct FailureListView: View {
    @Environment(AppState.self) private var appState
    @EnvironmentObject private var manager: GoalManager
    
    var body: some View {
        List {
            ForEach(manager.goals.filter { $0.state == 2 }) { goal in
                UnderwayCellView(goal: goal)
            }
        }
        .animation(.default, value: manager.goals)
        .listRowSpacing(10)
        .scrollContentBackground(.hidden)
    }
}

#Preview {
    FailureListView()
}

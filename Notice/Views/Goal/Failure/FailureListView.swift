//
//  FailureListView.swift
//  Notice
//
//  Created by 김민성 on 1/14/24.
//

import SwiftUI

struct FailureListView: View {
    @Environment(AppState.self) private var appState
    @Environment(GoalManager.self) private var goalManager
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [.init(), .init()]) {
                ForEach(goalManager.failures) { goal in
                    FailureCellView(goal: goal)
                }
            }
            .padding()
        }
        .animation(.default, value: goalManager.failures)
    }
}

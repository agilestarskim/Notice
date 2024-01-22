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
        ScrollView {
            LazyVGrid(columns: [.init(), .init()]) {
                ForEach(manager.failures ) { goal in
                    FailureCellView(goal: goal)
                }
            }
            .padding()
        }
        .animation(.default, value: manager.goals)        
    }
}

#Preview {
    FailureListView()
}

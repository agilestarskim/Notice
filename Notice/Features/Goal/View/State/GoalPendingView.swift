//
//  GoalPendingView.swift
//  Notice
//
//  Created by 김민성 on 1/1/24.
//

import SwiftUI

struct GoalPendingView: View {
    @Environment(AppState.self) private var appState
    @EnvironmentObject private var vm: GoalViewModel
    
    var body: some View {
        VStack {
            ForEach(vm.goals) { goal in
                PendingCardView(goal: goal)
            }
        }
    }
}

#Preview {
    GoalPendingView()
}

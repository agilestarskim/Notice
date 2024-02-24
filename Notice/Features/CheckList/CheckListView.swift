//
//  CheckListView.swift
//  Notice
//
//  Created by 김민성 on 1/5/24.
//

import SwiftUI

enum CheckTab: String, CaseIterable, Identifiable {
    var id: String { self.rawValue }
    
    case todo = "Todo"
    case routine = "Routine"
    case goal = "Goal"
}

struct CheckListView: View {
    @Environment(AppState.self) private var appState
    @State private var tab: CheckTab = .todo
    
    var body: some View {
        TabView(selection: $tab) {
            TodoView()
                .tag(CheckTab.todo)
            RoutineView()
                .tag(CheckTab.routine)
            GoalView()
                .tag(CheckTab.goal)
        }
        .animation(.default, value: self.tab)
        .background(appState.theme.background)
        .tabViewStyle(.page(indexDisplayMode: .never))
        .safeAreaInset(edge: .bottom) {
            NTPicker(tab: $tab)
                .padding(.bottom)
        }
    }
}

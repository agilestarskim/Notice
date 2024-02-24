//
//  GoalView.swift
//  Notice
//
//  Created by 김민성 on 1/5/24.
//

import SwiftUI

struct GoalView: View {
    enum GoalTab: String, CaseIterable, Identifiable {
        var id: String { self.rawValue }
        case underway = "Underway"
        case success = "Success"
        case failure = "Failure"
    }

    @Environment(AppState.self) private var appState
    @Environment(GoalManager.self) private var goalManager
    @State private var tab: GoalTab = .underway
    
    var body: some View {
        @Bindable var editManager = goalManager.editManager
        
        TabView(selection: $tab) {
            UnderwayListView()
                .tag(GoalTab.underway)
            SuccessListView()
                .tag(GoalTab.success)
            FailureListView()
                .tag(GoalTab.failure)
        }
        .animation(.default, value: self.tab)
        .tabViewStyle(.page(indexDisplayMode: .never))
        .sheet(isPresented: $editManager.shouldOpenEditor) {
            GoalFormView()
        }
        .sheet(item: $editManager.editingGoal) { _ in
            GoalFormView()
        }
        .safeAreaInset(edge: .top) {
            NTPicker(tab: $tab)
        }
        .onAppear(perform: goalManager.onAppear)
    }
}

//
//  GoalView.swift
//  Notice
//
//  Created by 김민성 on 1/5/24.
//

import SwiftUI

struct GoalView: View {
    @Environment(AppState.self) private var appState
    @Environment(GoalManager.self) private var goalManager
    
    var body: some View {
        @Bindable var editManager = goalManager.editManager
        VStack {
            GoalFilterPicker
            GoalList
        }
        .sheet(isPresented: $editManager.shouldOpenEditor) {
            GoalFormView()
        }
        .sheet(item: $editManager.editingGoal) { _ in
            GoalFormView()
        }
        .onAppear(perform: goalManager.onAppear)
    }
    
    var GoalFilterPicker: some View {
        @Bindable var filterManager = goalManager.filterManager
        return NTPicker(
            $filterManager.filter.animation(.easeInOut),
            GoalFilter.allCases,
            theme: appState.theme
        ) { oldValue, newValue in
            filterManager.setTabDirection(prevTab: oldValue, currentTab: newValue)
        }
        .padding(.horizontal)
    }
    
    var GoalList: some View {
        let filterManager = goalManager.filterManager
        return Group {
            switch filterManager.filter {
            case .underway:
                UnderwayListView()
            case .success:
                SuccessListView()
            case .failure:
                FailureListView()
            }
        }
        .animation(.easeInOut, value: filterManager.goingRight)
        .transition(
            .asymmetric(
                insertion: .move(edge: filterManager.goingRight ? .trailing : .leading),
                removal: .move(edge: filterManager.goingRight ? .leading : .trailing)
            )
        )
    }
}

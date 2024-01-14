//
//  GoalView.swift
//  Notice
//
//  Created by 김민성 on 1/5/24.
//

import SwiftUI

struct GoalView: View {
    @Environment(AppState.self) private var appState
    @EnvironmentObject private var manager: GoalManager
    
    var body: some View {
        VStack(spacing: 0) {
            GoalFilterPicker
            GoalList
        }
        .sheet(isPresented: $manager.shouldOpenEditor) {
            GoalFormView()
        }
        .onAppear {
            appState.onTapPlusButton = manager.onTapPlusButton
        }
    }
    
    var GoalFilterPicker: some View {
        NTPicker(
            $manager.filter.animation(.easeInOut),
            GoalFilter.allCases,
            theme: appState.theme
        ) { oldValue, newValue in
            manager.setTabDirection(prevTab: oldValue, currentTab: newValue)
        }
        .padding(.horizontal)
    }
    
    var GoalList: some View {
        Group {
            switch manager.filter {
            case .underway:
                UnderwayListView()
            case .success:
                SuccessListView()
            case .failure:
                FailureListView()
            }
        }
        .animation(.easeInOut, value: manager.goingRight)
        .transition(
            .asymmetric(
                insertion: .move(edge: manager.goingRight ? .trailing : .leading),
                removal: .move(edge: manager.goingRight ? .leading : .trailing)
            )
        )
    }
}

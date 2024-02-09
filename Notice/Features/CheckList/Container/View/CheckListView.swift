//
//  CheckListView.swift
//  Notice
//
//  Created by 김민성 on 1/5/24.
//

import SwiftUI

struct CheckListView: View {
    @Environment(AppState.self) private var appState
    @StateObject private var manager = CheckPickerManger()
    
    var body: some View {
        VStack {
            CheckList
            CheckPicker
        }
    }
    
    var CheckPicker: some View {
        NTPicker(
            $manager.checkTab.animation(.easeInOut),
            CheckTab.allCases,
            theme: appState.theme
        ) { oldValue, newValue in
            manager.setTabDirection(prevTab: oldValue, currentTab: newValue)
        }
        .padding(.horizontal)
    }
        
    var CheckList: some View {
        Group {
            switch manager.checkTab {
            case .todo:
                TodoView()
            case .routine:
                RoutineView()
            case .goal:
                GoalView()
            }
        }
        .transition(
            .asymmetric(
                insertion: .move(edge: manager.goingRight ? .trailing : .leading),
                removal: .move(edge: manager.goingRight ? .leading : .trailing)
            )
        )
    }
}

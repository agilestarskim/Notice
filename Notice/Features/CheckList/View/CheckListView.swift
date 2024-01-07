//
//  CheckListView.swift
//  Notice
//
//  Created by 김민성 on 1/5/24.
//

import SwiftUI

struct CheckListView: View {
    @Environment(AppState.self) private var appState
    @State private var checkType: CheckType = .todo
    
    var body: some View {
        NavigationStack {
            VStack {
                NTPicker(
                    $checkType,
                    CheckType.allCases,
                    theme: appState.theme
                )
                .padding(.horizontal)
                .padding(.top)
                switch checkType {
                case .todo:
                    TodoView()
                case .routine:
                    List {
                        RoutineView()
                    }
                case .goal:
                    List {
                        GoalView()
                    }                    
                }
            } 
            .background(appState.theme.background)
        }
    }
}

#Preview {
    CheckListView()
}

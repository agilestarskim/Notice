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
                TopPicker
                CheckList
            }
            .background(appState.theme.background)
        }
    }
    
    var TopPicker: some View {
        NTPicker(
            $checkType,
            CheckType.allCases,
            theme: appState.theme
        )
        .padding(.horizontal)
        .padding(.top)
    }
    
    @ViewBuilder
    var CheckList: some View {
        switch checkType {
        case .todo:
            TodoView()
        case .routine:
            RoutineView()            
        case .goal:
            List {
                GoalView()
            }
        }
    }
}

#Preview {
    CheckListView()
}

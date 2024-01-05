//
//  CheckListView.swift
//  Notice
//
//  Created by 김민성 on 1/5/24.
//

import SwiftUI

struct CheckListView: View {
    @State private var checkType: CheckType = .todo
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker("Check Type", selection: $checkType) {
                    ForEach(CheckType.allCases, id: \.self) { checkType in
                        Text(checkType.rawValue)
                            .tag(checkType)
                    }
                }
                .pickerStyle(.segmented)
                
                switch checkType {
                case .todo:
                    TodoView()
                case .routine:
                    RoutineView()
                case .goal:
                    GoalView()
                }
            }
            
        }
    }
}

#Preview {
    CheckListView()
}

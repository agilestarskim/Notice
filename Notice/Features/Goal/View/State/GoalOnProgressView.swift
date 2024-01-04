//
//  GoalOnProgressView.swift
//  Notice
//
//  Created by 김민성 on 1/1/24.
//

import SwiftUI

struct GoalOnProgressView: View {
    @Environment(AppState.self) private var appState
    @EnvironmentObject private var vm: GoalViewModel
    
    var body: some View {
        Group {
            if vm.viewMode == .lane {
                LaneView
            } else {
                CollectionView
            }
        }
    }
    
    var LaneView: some View {
        VStack {
            ForEach(GoalDuration.allCases, id: \.rawValue) { duration in
                VStack(alignment: .leading) {
                    Text(duration.title)
                        .fontWeight(.semibold)
                        .foregroundStyle(appState.theme.secondary)
                    ScrollView(.horizontal) {
                        LazyHStack {
                            ForEach(vm.goals) { goal in
                                LaneCardView(goal: goal)
                            }
                        }
                        .scrollTargetLayout()
                    }
                    .scrollTargetBehavior(.viewAligned)
                    .frame(height: 150)
                    .scrollIndicators(.hidden)
                }
            }
        }
    }
    
    var CollectionView: some View {
        LazyVStack {
            ForEach(vm.goals) { goal in
                CollectionCardView(goal: goal)
            }
        }
    }
}

//
//  GoalSuccessFailureView.swift
//  Notice
//
//  Created by 김민성 on 1/1/24.
//

import SwiftUI

struct GoalSuccessFailureView: View {
    @Environment(AppState.self) private var appState
    @EnvironmentObject private var vm: GoalViewModel
    
    let columns = Array(repeating: GridItem(.flexible(maximum: .infinity),spacing: 10), count: 2)
    
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
            ForEach(["2020", "2021", "2022"], id: \.self) { year in
                VStack(alignment: .leading) {
                    Text(year)
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
        LazyVGrid(columns: columns) {
            ForEach(vm.goals) { goal in
                CollectionCardView(goal: goal)
            }
        }
    }
}

#Preview {
    GoalSuccessFailureView()
}

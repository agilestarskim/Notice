//
//  UnderwayListView.swift
//  Notice
//
//  Created by 김민성 on 1/14/24.
//

import SwiftUI

struct UnderwayListView: View {    
    @Environment(AppState.self) private var appState
    @EnvironmentObject private var manager: GoalManager
    
    var body: some View {
        List {
            ForEach(manager.underways) { goal in
                UnderwayCellView(goal: goal)
            }
        }        
        .listRowSpacing(10)
        .scrollContentBackground(.hidden)
    }
}

#Preview {
    UnderwayListView()
}

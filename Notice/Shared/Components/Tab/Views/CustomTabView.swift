//
//  CustomTabView.swift
//  Notice
//
//  Created by 김민성 on 11/6/23.
//

import SwiftUI

struct CustomTabView: View {
    @Environment(AppState.self) private var appState
    let columns = Array(repeating: GridItem(spacing: 0, alignment: .bottom), count: 5)
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 0) {
            TabIcon(tab: .todo)
            TabIcon(tab: .routine)
            TabIcon(tab: .goal)
            TabIcon(tab: .memo)
            TabIcon(tab: .calendar)
        }
        .padding(.horizontal, 10)
        .padding(.top, 10)
        .frame(height: appState.tabHeight)
        .background(appState.theme.container)
    }
}

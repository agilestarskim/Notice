//
//  MainView.swift
//  Notice
//
//  Created by 김민성 on 11/5/23.
//

import SwiftUI

struct MainView: View {
    @Environment(AppState.self) private var appState
    
    var body: some View {
        VStack {
            switch appState.tab {
            case .calendar:
                CalendarView()
            case .check:
                CheckListView()
            case .memo:
                MemoView()
            case .stat:
                StatisticsView()
            }
        }
        .safeAreaInset(edge: .bottom) {
            CustomTabView()
        }
    }
}

//
//  MainView.swift
//  Notice
//
//  Created by 김민성 on 11/5/23.
//

import AlertToast
import SwiftUI

struct MainView: View {
    @Environment(AppState.self) private var appState
    
    var body: some View {
        @Bindable var bindableAppState = appState
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
        .background(appState.theme.background)
        .toast(isPresenting: $bindableAppState.shouldToastOn, duration: 1) {
            AlertToast(displayMode: .hud, type: .complete(.green), title: appState.toastMessage)            
        }
        .safeAreaInset(edge: .bottom) {
            CustomTabView()
        }
    }
}

//
//  MainView.swift
//  Notice
//
//  Created by 김민성 on 11/5/23.
//

import AlertToast
import SwiftData
import SwiftUI

struct MainView: View {    
    @State private var appState: AppState
    @State private var todoManager: TodoManager
    @State private var routineManager: RoutineManager
    @State private var goalManager: GoalManager
    
    @StateObject private var calendarViewModel: CalendarViewModel
    
    
    init() {
        let modelContext = NTModelContainer.shared.mainContext
        let appState = AppState()
        
        //삭제예정
        let calendarViewModel = CalendarViewModel(context: modelContext)
        
        self.appState = appState
        self._calendarViewModel = StateObject(wrappedValue: calendarViewModel)
        self.todoManager = TodoManager(appState: appState, context: modelContext)
        self.routineManager = RoutineManager(appState: appState, context: modelContext)
        self.goalManager = GoalManager(appState: appState, context: modelContext)
    }
    
    
    var body: some View {
        @Bindable var bindableAppState = appState
        VStack {
            switch appState.tab {
            case .calendar:
                CalendarView()
                    .environmentObject(calendarViewModel)
            case .check:
                CheckListView()
                    .environment(todoManager)
                    .environment(routineManager)
                    .environment(goalManager)
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
        .environment(appState)
    }
}

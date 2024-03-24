//
//  MainView.swift
//  Notice
//
//  Created by 김민성 on 11/5/23.
//

import AlertToast
import SwiftData
import SwiftUI

@MainActor
struct MainView: View {
    @State private var appState: AppState
    @State private var calendarManager: CalendarManager
    @State private var todoManager: TodoManager
    @State private var routineManager: RoutineManager
    @State private var goalManager: GoalManager
    @State private var memoManager: MemoManager
    
    init() {
        let modelContext = NTModelContainer.shared.mainContext
        let appState = AppState()
        
        self.appState = appState
        self.calendarManager = CalendarManager(appState: appState, context: modelContext)
        self.todoManager = TodoManager(appState: appState, context: modelContext)
        self.routineManager = RoutineManager(appState: appState, context: modelContext)
        self.goalManager = GoalManager(appState: appState, context: modelContext)
        self.memoManager = MemoManager(appState: appState, context: modelContext)
    }
    
    var body: some View {
        @Bindable var bindableAppState = appState
        TabView(selection: $bindableAppState.tab) {
            TodoMainView()
                .tag(Tabs.todo)
            RoutineMainView()
                .tag(Tabs.routine)
            GoalMainView()
                .tag(Tabs.goal)
            MemoMainView()
                .tag(Tabs.memo)
            CalendarMainView()
                .tag(Tabs.calendar)
        }
        .toast(isPresenting: $bindableAppState.shouldToastOn, duration: 1) {
            AlertToast(displayMode: .hud, type: .complete(.green), title: appState.toastMessage)            
        }
        .safeAreaInset(edge: .bottom) {
            if appState.shouldShowTab {
                CustomTabView()
                    .transition(.scale)
            }
        }
        .animation(.easeInOut, value: appState.shouldShowTab)
        .environment(appState)
        .environment(calendarManager)
        .environment(todoManager)
        .environment(routineManager)
        .environment(goalManager)
        .environment(memoManager)
    }
}

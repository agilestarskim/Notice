//
//  ContentView.swift
//  Notice
//
//  Created by 김민성 on 11/5/23.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @Environment(AppState.self) private var appState
    @StateObject private var calendarViewModel: CalendarViewModel
    @StateObject private var todoViewModel: TodoViewModel
    @StateObject private var goalViewModel: GoalViewModel
    
    init(context: ModelContext) {
        let calendarViewModel = CalendarViewModel(context: context)
        let todoViewModel = TodoViewModel(context: context)
        let goalViewModel = GoalViewModel(context: context)
        
        self._calendarViewModel = StateObject(wrappedValue: calendarViewModel)
        self._todoViewModel = StateObject(wrappedValue: todoViewModel)
        self._goalViewModel = StateObject(wrappedValue: goalViewModel)
    }
    
    var body: some View {
        VStack {
            switch appState.tab {
            case .calendar:
                CalendarView()
                    .environmentObject(calendarViewModel)
            case .todo:
                TodoListView()
                    .environmentObject(todoViewModel)
            case .goal:
                GoalView()
                    .environmentObject(goalViewModel)
            case .memo:
                MemoView()
            }
        }
        .safeAreaInset(edge: .bottom) {
            CustomTabView()
        }
    }
}

//
//  NoticeApp.swift
//  Notice
//
//  Created by 김민성 on 12/20/23.
//

import SwiftUI
import SwiftData

@main
struct NoticeApp: App {
    @State private var appState = AppState()
    @StateObject private var calendarViewModel: CalendarViewModel
    @StateObject private var todoViewModel: TodoViewModel
    @StateObject private var goalViewModel: GoalViewModel
    
    init() {
        let context = NoticeModelContainer.shared.mainContext
        
        let calendarViewModel = CalendarViewModel(context: context)
        let todoViewModel = TodoViewModel(context: context)
        let goalViewModel = GoalViewModel(context: context)
        
        self._calendarViewModel = StateObject(wrappedValue: calendarViewModel)
        self._todoViewModel = StateObject(wrappedValue: todoViewModel)
        self._goalViewModel = StateObject(wrappedValue: goalViewModel)
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .preferredColorScheme(.light)
        }        
        .environment(appState)
        .environmentObject(calendarViewModel)
        .environmentObject(todoViewModel)
        .environmentObject(goalViewModel)
    }
}

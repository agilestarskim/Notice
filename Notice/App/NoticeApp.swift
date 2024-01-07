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
    @StateObject private var todoManager: TodoManager
    @StateObject private var goalViewModel: GoalViewModel
    
    init() {
        let context = NTModelContainer.shared.mainContext
        
        let calendarViewModel = CalendarViewModel(context: context)
        let todoManager = TodoManager(context: context)
        let goalViewModel = GoalViewModel(context: context)
        
        self._calendarViewModel = StateObject(wrappedValue: calendarViewModel)
        self._todoManager = StateObject(wrappedValue: todoManager)
        self._goalViewModel = StateObject(wrappedValue: goalViewModel)
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .preferredColorScheme(.light)
        }        
        .environment(appState)
        .environmentObject(calendarViewModel)
        .environmentObject(todoManager)
        .environmentObject(goalViewModel)
    }
}

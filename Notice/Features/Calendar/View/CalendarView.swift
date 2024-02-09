//
//  CalendarView.swift
//  Notice
//
//  Created by 김민성 on 11/6/23.
//

import SwiftUI
import SwiftData

struct CalendarView: View {
    @Environment(AppState.self) private var appState
    @Environment(CalendarManager.self) private var calendarManager
    
    var body: some View {
        @Bindable var editor = calendarManager.editManager
        @Bindable var handler = calendarManager.handler
        NavigationStack {
            GeometryReader { geo in
                VStack(spacing: 0) {
                    MSCalendar(
                        handler: handler,
                        cellContent: { CalendarDayView(events: calendarManager.dailyEvents(by: $0)) }
                    )
                    .frame(height: geo.size.height * 0.5)                    
                    
                    CalendarDetailView(events: calendarManager.dailyEvents)
                        .frame(height: geo.size.height * 0.5)
                }
                .frame(maxHeight: .infinity)
                .background(appState.theme.background)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.hidden, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(NTFormatter.shared.string(calendarManager.pageDate, style: .yyyyMM))
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(appState.theme.accent)
                }
            }
        }        
        .sheet(isPresented: $editor.shouldOpenEditor) {
            CalendarFormView()
        }
        .onAppear(perform: calendarManager.onAppear)
        .onChange(of: handler.pageIndex, calendarManager.onSwipeCalendar)
    }
}

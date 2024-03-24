//
//  CalendarDetailView.swift
//  Notice
//
//  Created by 김민성 on 11/23/23.
//

import SwiftData
import SwiftUI


struct CalendarDetailView: View {
    @Environment(AppState.self) private var appState
    @Environment(CalendarManager.self) private var calendarManager
    let events: [Event]
    
    var body: some View {
        List {
            Section {
                if events.isEmpty {
                    Text("일정이 없습니다")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                        .font(.title3)
                        .foregroundStyle(appState.theme.primary)
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                } else{
                    ForEach(events) { event in
                        EventView(event: event)
                    }
                }
            } header: {
                HStack {
                    Text(NTFormatter.shared.string(calendarManager.selectedDate, style: .yyyyMMddE))
                    Text(calendarManager.calendar.isDateInToday(calendarManager.selectedDate) ? "Today" : "")
                    Spacer()
                    Button {
                        withAnimation {
                            calendarManager.onTapTodayButton()
                        }
                    } label: {
                        Image(systemName: "clock.arrow.circlepath")
                    }
                    .tint(appState.theme.container)
                    .buttonStyle(.borderedProminent)
                }
                .foregroundStyle(appState.theme.secondary)
            }                        
        }
        .listRowSpacing(10)
        .listStyle(.grouped)
        .scrollContentBackground(.hidden)          
        .safeAreaPadding(.bottom, appState.bottomSafeAreaPadding)
    }
}

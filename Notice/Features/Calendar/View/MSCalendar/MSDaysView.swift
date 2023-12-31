//
//  MSDaysView.swift
//  Notice
//
//  Created by 김민성 on 12/10/23.
//

import SwiftUI

struct MSDaysView<Content: View>: View {    
    @Environment(AppState.self) private var appState
    @Binding var selectedDate: Date
    
    let pageDate: Date
    let dates: [Date]
    let calendar: Calendar
    let content: (Date) -> Content    
    let columns = Array(repeating: GridItem(spacing: 0, alignment: .top), count: 7)
    
    var body: some View {        
        LazyVGrid(columns: self.columns, spacing: 0) {
            ForEach(dates, id: \.self) { day in
                MSDayView(
                    day: day,
                    isSameMonth:  isSameMonth(day),
                    isSameDay: isSameDay(day, selectedDate),
                    textColor: calendarDayColor(day),
                    selectedColor: appState.theme.secondary,
                    content: content
                )
                .onTapGesture {
                    if isSameMonth(day) {                        
                        selectedDate = day.stripTime()
                    }
                } 
            }
        }        
    }
    
    private func isSameMonth(_ date: Date) -> Bool {
        calendar.isDate(date, equalTo: pageDate, toGranularity: .month)
    }
    
    private func isSameDay(_ date1: Date, _ date2: Date) -> Bool {
        calendar.isDate(date1, equalTo: date2, toGranularity: .day)
    }
    
    private func calendarDayColor(_ date: Date) -> Color {
        if isSameDay(.now, date) {
            return appState.theme.accent
        } else if calendar.isDateInWeekend(date) {
            return appState.theme.secondary
        } else {
            return appState.theme.primary
        }
    }    
}

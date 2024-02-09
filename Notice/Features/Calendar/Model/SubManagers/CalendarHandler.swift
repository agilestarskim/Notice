//
//  CalendarHandler.swift
//  Notice
//
//  Created by 김민성 on 2/4/24.
//

import SwiftData
import SwiftUI
import Observation

extension CalendarManager {
    @Observable
    final class CalendarHandler {
        let calendar: Calendar
        private let appState: AppState
        
        var selectedDate: Date = .now
        var pageIndex: Int? = 0
        
        init(calendar: Calendar, appState: AppState) {
            self.calendar = calendar
            self.appState = appState
        }
        
        var pageDate: Date {
            guard let index = pageIndex else { return .now }
            return calendar.date(byAdding: .month, value: index, to: .now)?.startOfMonth() ?? .now
        }
        
        // MARK: - MSInfiniteMonthView
        
        func pageDate(index: Int) -> Date {            
            calendar.date(byAdding: .month, value: index, to: .now)?.startOfMonth() ?? .now
        }
        
        func makeDays(from index: Int) -> [Date] {
            guard let monthInterval = calendar.dateInterval(of: .month, for: self.pageDate(index: index)),
                  let monthFirstWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.start),
                  let monthLastWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.end - 1)
            else { return [] }
           
            let dateInterval = DateInterval(start: monthFirstWeek.start, end: monthLastWeek.end)
            
            return calendar.generateDays(for: dateInterval)
        }
        
        func onChangePage() {
            if isSameMonth(.now, pageDate) {
                selectedDate = .now
            } else {
                selectedDate = pageDate
            }
        }
        
        // MARK: - MSDaysView
        
        func isSameMonth(_ date: Date, _ date2: Date) -> Bool {
            calendar.isDate(date, equalTo: date2, toGranularity: .month)
        }
        
        func isSameDay(_ date1: Date, _ date2: Date) -> Bool {
            calendar.isDate(date1, equalTo: date2, toGranularity: .day)
        }
        
        func calendarDayColor(_ date: Date) -> Color {
            if isSameDay(.now, date) {
                return appState.theme.accent
            } else if calendar.isDateInWeekend(date) {
                return appState.theme.secondary
            } else {
                return appState.theme.primary
            }
        }
        
        func onTapCellContent(_ date: Date) {
            if isSameMonth(date, pageDate) {
                selectedDate = date.stripTime()
            }
        }
        
        // MARK: - MSWeekTitleView
        
        var dayOfWeekStrings: [String] {
            let formatter = DateFormatter()
            formatter.locale = Locale.current
            let weekdays = formatter.shortWeekdaySymbols ?? ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
            return weekdays
        }
    }
}

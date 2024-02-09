//
//  CalendarDBManager.swift
//  Notice
//
//  Created by 김민성 on 2/4/24.
//

import SwiftData
import SwiftUI
import Observation

extension CalendarManager {
    @Observable
    final class DBManager {        
        var events: [Event] = []
        
        private let context: ModelContext
        private let calendar: Calendar
        
        init(context: ModelContext, calendar: Calendar) {
            self.context = context
            self.calendar = calendar
        }
        
        func fetch(pageDate: Date) {
            let startOfMonth = pageDate
            let nextMonth = calendar.date(byAdding: .month, value: 1, to: startOfMonth) ?? .now
            let endOfMonth = calendar.date(byAdding: .day, value: -1, to: nextMonth) ?? .now
            let predicate = #Predicate<Event> { event in
                startOfMonth <= event.startDate && event.startDate <= endOfMonth
            }
            let sort = SortDescriptor(\Event.startDate)
            let fetchDescriptor = FetchDescriptor<Event>(predicate: predicate, sortBy: [sort])
            
            do {
                self.events = try context.fetch(fetchDescriptor)
            } catch {
                print("Fail to fetch Events")
            }
        }
        
        func create(_ event: Event) {
            self.context.insert(event)
        }
        
        func update(origin: Event, _ newEvent: Event) {
            origin.title = newEvent.title
            origin.memo = newEvent.memo
            origin.category = newEvent.category
            origin.startDate = newEvent.startDate
        }
        
        func delete(_ event: Event) {
            context.delete(event)
        }
    }
}

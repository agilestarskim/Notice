//
//  CalendarViewModel.swift
//  Notice
//
//  Created by 김민성 on 11/23/23.
//

import SwiftUI
import SwiftData

final class CalendarViewModel: ObservableObject {
    @Published var events: [Event] = []
    @Published var selectedDate: Date = .now
    @Published var pageIndex: Int? = 0
    @Published var isOpenEditorToCreate = false
    @Published var isOpenEditorToEdit = false
    
    private let context: ModelContext
    
    let calendar: Calendar = {
        var calendar = Calendar.current
        calendar.locale = .current
        calendar.timeZone = .current
        return calendar
    }()
    
    init(context: ModelContext) {
        self.context = context
        fetchMontlyEvents()
    }
    
    func create(_ event: Event) {
        self.context.insert(event)        
        fetchMontlyEvents()
    }
    
    func update(origin: Event, edit: Event) {
        origin.title = edit.title
        origin.memo = edit.memo
        origin.category = edit.category
        origin.startDate = edit.startDate
        
        fetchMontlyEvents()
    }
    
    func delete(_ event: Event) {
        context.delete(event)
        fetchMontlyEvents()
    }
    
    func onTapPlusButton() {
        isOpenEditorToCreate = true
    }
    
    func onTapEditButton() {
        isOpenEditorToEdit = true
    }
    
    func gotoToday() {
        selectedDate = .now
        pageIndex = 0
    }
    
    var pageDate: Date {
        guard let index = pageIndex else { return .now }
        return calendar.date(byAdding: .month, value: index, to: .now)?.startOfMonth() ?? .now
    }
    
    func fetchMontlyEvents() {
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
    
    var dailyEvents: [Event] {
        self.events
            .filter { calendar.isDate($0.startDate, inSameDayAs: selectedDate) }
            .sorted { $0.startDate < $1.startDate }
    }
    
    func dailyEvents(by date: Date) -> [Event] {
        self.events
            .filter { calendar.isDate($0.startDate, inSameDayAs: date) }
            .sorted { $0.startDate < $1.startDate }
            .prefix(3)
            .map { $0 }
    }    
}

//
//  CalendarManager.swift
//  Notice
//
//  Created by 김민성 on 2/4/24.
//

import Foundation
import Observation
import SwiftData

@Observable
final class CalendarManager {
    let appState: AppState
    let context: ModelContext
    let formatter: NTFormatter
    let calendar: Calendar
    
    let dbManager: DBManager
    let editManager: EditManager
    let handler: CalendarHandler
    
    init(
        appState: AppState,
        context: ModelContext,
        formatter: NTFormatter = NTFormatter.shared,
        calendar: Calendar = Calendar.autoupdatingCurrent
    ) {
        self.appState = appState
        self.context = context
        self.formatter = formatter
        self.calendar = calendar
        
        self.dbManager = DBManager(context: context, calendar: calendar)
        self.editManager = EditManager()
        self.handler = CalendarHandler(calendar: calendar, appState: appState)
    }
    
    var events: [Event] {
        dbManager.events
    }
    
    var pageIndex: Int? {
        handler.pageIndex
    }
    
    var pageDate: Date {
        handler.pageDate
    }
    
    var selectedDate: Date {
        handler.selectedDate
    }
    
    var dailyEvents: [Event] {
        dbManager.events
            .filter { calendar.isDate($0.startDate, inSameDayAs: selectedDate) }
            .sorted { $0.startDate < $1.startDate }
    }
    
    func dailyEvents(by date: Date) -> [Event] {
        dbManager.events
            .filter { calendar.isDate($0.startDate, inSameDayAs: date) }
            .sorted { $0.startDate < $1.startDate }
            .prefix(3)
            .map { $0 }
    }
    
    func onAppear() {
        setOnTapPlusButton()
        dbManager.fetch(pageDate: pageDate)
    }
    
    private func setOnTapPlusButton() {
        appState.onTapPlusButton = nil
        appState.onTapPlusButton = { [weak self] in
            self?.editManager.shouldOpenEditor = true
            self?.editManager.setData(self?.selectedDate)
        }
    }
    
    func onSwipeCalendar() {
        dbManager.fetch(pageDate: pageDate)
    }
    
    func onTapEditEventButton(_ event: Event) {
        editManager.editingEvent = event
        editManager.setData(selectedDate)
    }
    
    func onTapDeleteEventButton(_ event: Event) {
        dbManager.delete(event)
        dbManager.fetch(pageDate: pageDate)
    }
    
    func onTapEditEventDoneButton() {
        let newEvent = editManager.createNewEvent()
        
        if let origin = editManager.editingEvent {
            dbManager.update(origin: origin, newEvent)
        } else {
            dbManager.create(newEvent)
        }
        editManager.resetData()
        dbManager.fetch(pageDate: pageDate)        
    }
    
    func onTapTodayButton() {
        handler.selectedDate = .now
        handler.pageIndex = 0
    }
}

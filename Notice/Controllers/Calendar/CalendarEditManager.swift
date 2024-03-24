//
//  CalendarEditManager.swift
//  Notice
//
//  Created by 김민성 on 2/4/24.
//

import SwiftData
import SwiftUI
import Observation

extension CalendarManager {
    @Observable
    final class EditManager {
        var shouldOpenEditor: Bool = false
        var editingEvent: Event? = nil
        
        var title: String = ""
        var memo: String = ""
        var category: String = EventCategory.meeting.rawValue
        var startDate: Date = .now
        
        func setData(_ selectedDate: Date?) {
            if let event = editingEvent {
                self.title = event.title
                self.memo = event.memo
                self.category = event.category
                self.startDate = event.startDate
            } else if let selectedDate {
                self.startDate = selectedDate
            }
        }
        
        func resetData() {
            self.title = ""
            self.memo = ""
            self.category = EventCategory.meeting.rawValue
            self.startDate = .now
        }
        
        func createNewEvent() -> Event {
            return Event(
                title: title,
                memo: memo,
                category: category,
                startDate: startDate
            )
        }
    }
}


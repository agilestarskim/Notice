//
//  GoalEditManager.swift
//  Notice
//
//  Created by 김민성 on 2/1/24.
//

import SwiftData
import SwiftUI
import Observation

extension GoalManager {
    @Observable
    final class EditManager {
        let calendar: Calendar
        var shouldOpenEditor = false
        var editingGoal: Goal? = nil
        
        var title: String = ""
        var emoji: Int = 0x1F3C6
        var startDate: Date = .now
        var endDate: Date = .now
        var duration: GoalDuration = .week        
        var state: Int = 0
        
        init(calendar: Calendar) {
            self.calendar = calendar
        }
        
        enum EditState { case create, edit, retry }
        
        var editState: EditState {
            if editingGoal == nil {
                return .create
            } else if editingGoal != nil && state != 2 {
                return .edit
            } else {
                return .retry
            }
        }
        
        var formTitle: String {
            switch editState {
            case .create:
                return "목표 추가"
            case .edit:
                return "목표 편집"
            case .retry:
                return "목표 재도전"
            }
        }
        
        var isTitleEmpty: Bool {
            title.isEmpty
        }
        
        func createNewGoal() -> Goal {
            Goal(
                title: title,
                emoji: emoji,
                startDate: startDate,
                endDate: endDate,
                realEndDate: .now,
                duration: duration.rawValue,
                state: state
            )
        }
        
        func setData() {
            switch editState {
            case .create:
                break
            case .edit:
                if let goal = editingGoal{
                    self.title = goal.title
                    self.emoji = goal.emoji
                    self.startDate = goal.startDate
                    self.endDate = goal.endDate
                    self.duration = GoalDuration(rawValue: goal.duration) ?? .week
                    self.state = goal.state
                }
            case .retry:
                if let goal = editingGoal{
                    self.title = goal.title
                    self.emoji = goal.emoji
                    self.duration = .week
                    self.state = goal.state
                }
            }
            setEndDate()
        }
        
        func resetData() {
            title = ""
            emoji = 0x1F3C6
            startDate = .now
            endDate = .now
            duration = .week
            state = 0
        }
        
        func setEndDate() {
            if let endDate = calculateEndDate(duration, after: startDate) {
                self.endDate = endDate
            }
        }
        
        private func calculateEndDate(
            _ duration: GoalDuration,
            after startDate: Date
        ) -> Date? {
            switch duration {
            case .week:
                return calendar.date(byAdding: .weekOfYear, value: 1, to: startDate)
            case .oneMonth:
                return calendar.date(byAdding: .month, value: 1, to: startDate)
            case .threeMonth:
                return calendar.date(byAdding: .month, value: 3, to: startDate)
            case .year:
                return calendar.date(byAdding: .year, value: 1, to: startDate)
            case .custom:
                return nil
            }
        }
        
        
        
    }
}


//
//  GoalViewModel.swift
//  Notice
//
//  Created by 김민성 on 1/1/24.
//

import Foundation
import Observation
import SwiftData
import SwiftUI

@Observable
final class GoalManager {
    let appState: AppState
    let context: ModelContext
    let formatter: NTFormatter
    let calendar: Calendar
    
    let dbManager: DBManager
    let editManager: EditManager
    
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
        
        self.dbManager = GoalManager.DBManager(context: context)
        self.editManager = GoalManager.EditManager(calendar: calendar)
    }
    
    var underways: [Goal] {
        dbManager.goals.filter { $0.state == 0 }
    }
    
    var successes: [Goal] {
        dbManager.goals
            .filter { $0.state == 1 }
            .sorted {
                $0.realEndDate > $1.realEndDate
            }
    }
    
    var failures: [Goal] {
        dbManager.goals.filter { $0.state == 2 }
    }
    
    func onAppear() {
        appState.onTapPlusButton = self.onTapPlusButton
        dbManager.fetch()
    }
    
    func onTapPlusButton() {
        editManager.shouldOpenEditor = true
    }
    
    func onTapEditButton(goal: Goal) {
        editManager.editingGoal = goal
    }
    
    func onTapDeleteButton(goal: Goal) {
        dbManager.delete(goal)
    }
    
    func onTapEditDoneButton() {
        let newGoal = editManager.createNewGoal()
        
        if let origin = editManager.editingGoal {
            dbManager.update(origin: origin, newGoal)
        } else {
            dbManager.create(newGoal)
        }
        
        editManager.resetData()
    }
    
    func deadline(_ goal: Goal) -> Int? {
        let deadline = calendar.dateComponents(
            [.day],
            from: .now.stripTime(),
            to: goal.endDate.stripTime()
        ).day ?? 0
        
        if deadline >= 0 {
            return deadline
        } else {
            return nil
        }
    }
}


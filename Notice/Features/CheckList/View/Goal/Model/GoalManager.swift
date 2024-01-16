//
//  GoalViewModel.swift
//  Notice
//
//  Created by 김민성 on 1/1/24.
//

import SwiftData
import SwiftUI

final class GoalManager: ObservableObject {
    @Published var goals: [Goal] = []
    @Published var filter: GoalFilter = .underway
    @Published var goingRight: Bool = false
    @Published var shouldOpenEditor = false
    @Published var editingGoal: Goal? = nil
    
    private let context: ModelContext
    private let calendar: Calendar = Calendar.shared
    
    var underways: [Goal] {
        goals.filter { $0.state == 0 }
    }
    
    var successes: [Goal] {
        goals.filter { $0.state == 1 }
    }
    
    var failures: [Goal] {
        goals.filter { $0.state == 2 }
    }
    
    init(context: ModelContext) {
        self.context = context
        fetchGoals()
    }
    
    func fetchGoals() {
        do {
            let sorts = [SortDescriptor(\Goal.endDate)]
            self.goals = try context.fetch(FetchDescriptor<Goal>(sortBy: sorts))
        } catch {
            print("failed to load goals")
        }
    }
    
    func onTapPlusButton() {
        shouldOpenEditor = true
    }
    
    func onTapEditButton(goal: Goal) {
        editingGoal = goal
    }
    
    func setTabDirection(prevTab: GoalFilter, currentTab: GoalFilter) {
        if prevTab.index - currentTab.index < 0 {
            self.goingRight = true
        } else {
            self.goingRight = false
        }
    }
    
    func create(_ goal: Goal) {
        context.insert(goal)
        fetchGoals()
    }
    
    func update(_ newGoal: Goal) {
        if let origin = editingGoal {
            origin.title = newGoal.title            
            origin.image = newGoal.image
            origin.startDate = newGoal.startDate
            origin.endDate = newGoal.endDate
                        
            if origin.state == 2 { origin.state = 0 }
            
            fetchGoals()
        }
    }
    
    func calculateEndDate(
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
    
    func editState(_ state: Int) -> EditState {
        if editingGoal == nil {
            return .create
        } else if editingGoal != nil && state != 2 {
            return .edit
        } else {
            return .retry
        }
    }
    
    enum EditState { case create, edit, retry }
    
    func deadline(_ goal: Goal) -> Int? {
        let deadline = Calendar.shared.dateComponents(
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


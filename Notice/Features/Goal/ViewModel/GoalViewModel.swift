//
//  GoalViewModel.swift
//  Notice
//
//  Created by 김민성 on 1/1/24.
//

import SwiftData
import SwiftUI

final class GoalViewModel: ObservableObject {
    @Published var goals: [Goal] = []
    @Published var filter: GoalFilter = .onProgress
    @Published var viewMode: GoalViewMode = .collection
    @Published var isOpenEditorToCreate = false
    @Published var editingGoal: Goal? = nil
    
    private let context: ModelContext
    
    let calendar: Calendar = {
        var calendar = Calendar.current
        calendar.locale = .current
        calendar.timeZone = .current
        return calendar
    }()
    
    init(context: ModelContext) {
        self.context = context
        fetchGoals()
    }
    
    func fetchGoals() {
        do {
            self.goals = try context.fetch(FetchDescriptor<Goal>())
        } catch {
            print("failed to load goals")
        }
    }
    
    func onTapPlusButton() {
        isOpenEditorToCreate = true
    }
    
    func onTapEditButton(goal: Goal) {        
        editingGoal = goal
    }
    
    func create(_ goal: Goal) {
        context.insert(goal)
        fetchGoals()
    }
    
    func update(_ newGoal: Goal) {
        if let origin = editingGoal {
            origin.title = newGoal.title
            origin.memo = newGoal.memo
            origin.image = newGoal.image       
            
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
        case .forever:
            return forever
        case .custom:
            return nil
        }        
    }
    
    var viewModeButtonImage: String {
        if viewMode == .collection {
            return "line.3.horizontal"
        } else {
            return "rectangle.grid.2x2"
        }
    }
    
    var forever: Date {
        var dateComponents = DateComponents()
        dateComponents.year = 4000
        
        return calendar.date(from: dateComponents) ?? .distantFuture
    }
    
    func isForever(_ date: Date) -> Bool {
        calendar.isDate(date, inSameDayAs: forever)
    }
    
}


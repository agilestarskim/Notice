//
//  GoalDBManager.swift
//  Notice
//
//  Created by 김민성 on 2/1/24.
//

import SwiftData
import SwiftUI
import Observation

extension GoalManager {
    @Observable
    final class DBManager {
        var goals: [Goal] = []
        
        private let context: ModelContext
        
        init(context: ModelContext) {
            self.context = context
        }
        
        func fetch() {
            do {
                let sorts = [SortDescriptor(\Goal.endDate)]
                self.goals = try context.fetch(FetchDescriptor<Goal>(sortBy: sorts))
            } catch {
                print("failed to load goals")
            }
        }
        
        func create(_ goal: Goal) {
            context.insert(goal)
            fetch()
        }
        
        func update(origin: Goal, _ newGoal: Goal) {
            origin.title = newGoal.title
            origin.emoji = newGoal.emoji
            origin.startDate = newGoal.startDate
            origin.endDate = newGoal.endDate
            origin.duration = newGoal.duration
                        
            if origin.state == 2 {
                origin.state = 0
            }
            
            fetch()
        }
        
        func delete(_ goal: Goal) {
            context.delete(goal)
            fetch()
        }
    }
}

//
//  RoutineDBManager.swift
//  Notice
//
//  Created by 김민성 on 1/29/24.
//

import SwiftData
import SwiftUI
import Observation

extension RoutineManager {
    @Observable
    final class DBManager {
        var routines: [Routine] = []
        
        private let context: ModelContext
        
        init(context: ModelContext) {
            self.context = context
        }
        
        func fetch() {
            let sort = [
                SortDescriptor(\Routine.startDate)
            ]
            
            let fetchDescriptor = FetchDescriptor(sortBy: sort)
            
            do {
                self.routines = try context.fetch(fetchDescriptor)
            } catch {
                print("Fail to fetch Routines")
            }
        }
        
        func create(_ routine: Routine) {
            context.insert(routine)
            fetch()
        }
        
        func update(origin: Routine, _ newRoutine: Routine) {
            context.delete(origin)
            context.insert(newRoutine)
            fetch()
        }
        
        func delete(_ routine: Routine) {
            context.delete(routine)
            fetch()
        }
        
        func done(_ routine: Routine) {
            guard let performedDates = routine.performedDates else { return }
            
            let date = NTFormatter.shared.string(.now, style: .performedDate)
            let performedDate = PerformedDate(date: date)
            
            if isNew(performedDate.date, in: performedDates) {
                routine.performedDates?.append(performedDate)
            }
        }
        
        private func isNew(
            _ performedDate: String,
            in performedDates: [PerformedDate]
        ) -> Bool {
            for pd in performedDates {
                if pd.date == performedDate {
                    return false
                }
            }
            return true
        }
    }
}

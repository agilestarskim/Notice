//
//  RoutineViewModel.swift
//  Notice
//
//  Created by 김민성 on 1/5/24.
//

import SwiftData
import SwiftUI


final class RoutineManager: ObservableObject {
    @Published var routines: [Routine] = []
    @Published var shouldOpenEditor = false
    @Published var editingRoutine: Routine? = nil
    
    private let context: ModelContext
    private let calendar: Calendar = Calendar.shared
    
    init(context: ModelContext) {
        self.context = context
        fetchRoutines()
    }
    
    func fetchRoutines() {
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
    
    func onTapPlusButton() {
        shouldOpenEditor = true
    }
    
    func onTapEditButton(routine: Routine) {
        editingRoutine = routine
    }
    
    func create(_ routine: Routine) {
        context.insert(routine)
        fetchRoutines()
    }
    
    func update(_ newRoutine: Routine) {
        if let origin = editingRoutine {
            context.delete(origin)
            context.insert(newRoutine)
            fetchRoutines()
        }
    }
    
    func delete(_ routine: Routine) {
        context.delete(routine)
        fetchRoutines()
    }
    
    func toggleDone(_ routine: Routine) {
        guard let performedDates = routine.performedDates else { return }
        
        let date = DateFormatter.string(.now, style: .performedDate)
        let performedDate = PerformedDate(date: date)
        
        if isNew(performedDate.date, in: performedDates) {
            routine.performedDates?.append(performedDate)
        }
    }
    
    func doneButtonImage(isChecked: Bool) -> Image {
        if isChecked {
            return Image(systemName: "circle.circle.fill")
        } else {
            return Image(systemName: "circle")
        }
    }
    
    func getDay(from date: Date) -> Int {                      
        (Calendar.shared.dateComponents(
            [.day],
            from: date.stripTime(),
            to: .now.stripTime()
        ).day ?? -1) + 1
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

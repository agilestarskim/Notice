//
//  RoutineViewModel.swift
//  Notice
//
//  Created by 김민성 on 1/5/24.
//

import Foundation
import Observation
import SwiftData

@Observable
final class RoutineManager {
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
        
        self.dbManager = RoutineManager.DBManager(context: context)
        self.editManager = RoutineManager.EditManager()
        
    }
    
    var routines: [Routine] {
        dbManager.routines
    }
    
    func onAppear() {
        appState.onTapPlusButton = self.onTapPlusButton
        dbManager.fetch()
    }
    
    private func onTapPlusButton() {
        editManager.shouldOpenEditor = true
    }
    
    func onTapEditButton(routine: Routine) {
        editManager.editingRoutine = routine
        editManager.setData()
    }
    
    func onTapDoneButton(of routine: Routine) {
        dbManager.done(routine)
        appState.showToast("\(formatter.string(.now, style: .MdE)) 완료했습니다")
    }
    
    func onTapDeleteButton(_ routine: Routine) {
        dbManager.delete(routine)
    }
    
    func onTapEditDoneButton() {
        let newRoutine = editManager.createNewRoutine()
        
        if let origin = editManager.editingRoutine {
            dbManager.update(origin: origin, newRoutine)
        } else {
            dbManager.create(newRoutine)
        }
        
        editManager.resetData()
    }
    
    func getDay(from date: Date) -> Int {
        (calendar.dateComponents(
            [.day],
            from: date.stripTime(),
            to: .now.stripTime()
        ).day ?? -1) + 1
    }
    
    func getPerformedDates(of routine: Routine) -> [String] {
        if let performedDates = routine.performedDates {
            return performedDates.map { $0.date }
        } else {
            return []
        }
    }
}

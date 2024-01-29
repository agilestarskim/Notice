//
//  RoutineEditManager.swift
//  Notice
//
//  Created by 김민성 on 1/29/24.
//

import Foundation
import Observation
import SwiftUI

extension RoutineManager {
    @Observable
    final class EditManager {
        var shouldOpenEditor = false
        var editingRoutine: Routine? = nil
        
        var title: String = ""
        var startDate: Date = .now
        var color: Color = .red
        
        var formContainerTitle: String {
            if editingRoutine == nil {
                return "루틴 추가"
            } else {
                return "루틴 편집"
            }
        }
        
        var isTitleEmpty: Bool {
            title.isEmpty
        }
        
        func setData() {
            if let routine = editingRoutine {
                self.title = routine.title
                self.startDate = routine.startDate
                self.color = routine.color.toColor
            }
        }
        
        func resetData() {
            self.title = ""
            self.startDate = .now
            self.color = .red
        }
        
        func createNewRoutine() -> Routine {
            let performedDates = editingRoutine?.performedDates ?? []
            
            return Routine(
                title: title,
                startDate: startDate,
                color: color.description,
                performedDates: performedDates)
        }
    }
}

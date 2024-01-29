//
//  DataManager.swift
//  Notice
//
//  Created by 김민성 on 1/23/24.
//

import Foundation
import Observation

extension TodoManager {
    @Observable
    final class FilterManager {
        var todoFilter: TodoFilter = .today
        var goingRight: Bool = false
        
        func setTabDirection(prevTab: TodoFilter, currentTab: TodoFilter) {
            if prevTab.index - currentTab.index < 0 {
                self.goingRight = true
            } else {
                self.goingRight = false
            }
        }
    }
}

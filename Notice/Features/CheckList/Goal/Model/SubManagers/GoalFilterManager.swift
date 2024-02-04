//
//  GoalFilterManager.swift
//  Notice
//
//  Created by 김민성 on 2/1/24.
//

import SwiftData
import SwiftUI
import Observation

extension GoalManager {
    @Observable
    final class FilterManager {
        var filter: GoalFilter = .underway
        var goingRight: Bool = false
        
        func setTabDirection(prevTab: GoalFilter, currentTab: GoalFilter) {
            if prevTab.index - currentTab.index < 0 {
                self.goingRight = true
            } else {
                self.goingRight = false
            }
        }
    }
}

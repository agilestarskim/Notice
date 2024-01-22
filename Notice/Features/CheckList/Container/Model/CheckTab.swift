//
//  CheckType.swift
//  Notice
//
//  Created by 김민성 on 1/5/24.
//

import Foundation

enum CheckTab: String, CaseIterable {
    case todo = "Todo"
    case routine = "Routine"
    case goal = "Goal"
    
    var index: Int {
        switch self {
        case .todo:
            1
        case .routine:
            2
        case .goal:
            3
        }
    }
}

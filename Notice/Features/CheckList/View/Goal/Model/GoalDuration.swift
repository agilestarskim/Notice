//
//  GoalDuration.swift
//  Notice
//
//  Created by 김민성 on 1/1/24.
//

import Foundation

enum GoalDuration: Int, CaseIterable {
    case week = 0
    case oneMonth
    case threeMonth
    case year
    case custom
    
    var title: String {
        switch self {
        case .week:
            "A week"
        case .oneMonth:
            "A Month"
        case .threeMonth:
            "3 Months"
        case .year:
            "A Year"        
        case .custom:
            "Custom"
        }
    }
}

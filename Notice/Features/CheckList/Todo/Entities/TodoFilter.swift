//
//  TodoFilter.swift
//  Notice
//
//  Created by 김민성 on 1/13/24.
//

import Foundation

enum TodoFilter: String, CaseIterable {
    case today = "Today"
    case all = "All"
    
    var index: Int {
        switch self {
        case .today:
            1
        case .all:
            2
        }
    }
}

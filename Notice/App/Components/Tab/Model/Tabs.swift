//
//  Tabs.swift
//  Notice
//
//  Created by 김민성 on 11/6/23.
//

import Foundation

enum Tabs: CaseIterable {
    
    case calendar, check, memo, stat
    
    var label: String {
        switch self {
        case .calendar:
            "Calendar"
        case .check:
            "Check"
        case .memo:
            "Memo"
        case .stat:
            "Stat"
        }
    }
    
    var image: String {
        switch self {
        case .calendar:
            "calendar"
        case .check:
            "checklist.checked"
        case .memo:
            "book.pages"
        case .stat:
            "chart.bar.xaxis"
        }
    }
}

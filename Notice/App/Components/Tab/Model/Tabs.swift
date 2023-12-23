//
//  Tabs.swift
//  Notice
//
//  Created by 김민성 on 11/6/23.
//

import Foundation

enum Tabs: CaseIterable {
    
    case calendar, todo, goal, memo
    
    var label: String {
        switch self {
        case .calendar:
            "Calendar"
        case .todo:
            "Todo"
        case .goal:
            "Goal"
        case .memo:
            "Memo"
        }
    }
    
    var image: String {
        switch self {
        case .calendar:
            "calendar"
        case .todo:
            "checklist.checked"
        case .goal:
            "target"
        case .memo:
            "book.pages"
        }
    }
}

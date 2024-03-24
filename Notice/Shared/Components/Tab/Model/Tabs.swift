//
//  Tabs.swift
//  Notice
//
//  Created by 김민성 on 11/6/23.
//

import Foundation

enum Tabs: CaseIterable {
    case todo, routine, goal, memo, calendar
    
    var label: String {
        switch self {
        case .todo:
            "할 일"
        case .routine:
            "루틴"
        case .goal:
            "목표"
        case .memo:
            "메모"
        case .calendar:
            "달력"
        }
    }
    
    var image: String {
        switch self {
        case .todo:
            "checklist.checked"
        case .routine:
            "figure.run"
        case .goal:
            "target"
        case .memo:
            "book.pages"
        case .calendar:
            "calendar"
        }
    }
}

//
//  EventCategory.swift
//  Notice
//
//  Created by 김민성 on 12/20/23.
//

import SwiftUI

enum EventCategory: String, CaseIterable {
    case meeting = "Meeting"
    case date = "Date"
    case business = "Business"
    case anniversary = "Anniversary"
    case vacation = "Vacation"
    case `class` = "Class"
    case workout = "Workout"
    case none = "None"
    
    static func color(_ category: String) -> Color {
        guard let eventCategory = EventCategory(rawValue: category) else { return .gray }
        return eventCategory.color        
    }
    
    var color: Color {
        switch self {
        case .meeting:
            Color.orange
        case .date:
            Color.red
        case .business:
            Color.green
        case .anniversary:
            Color.blue
        case .vacation:
            Color.cyan
        case .class:
            Color.yellow
        case .workout:
            Color.teal
        case .none:
            Color.gray
        }
    }
}

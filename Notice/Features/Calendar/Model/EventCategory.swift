//
//  EventCategory.swift
//  Notice
//
//  Created by 김민성 on 12/20/23.
//

import SwiftUI

enum EventCategory: String, CaseIterable {
    case meeting = "meeting"
    case anniversary = "anniversary"
    case vacation = "vacation"
    case study = "study"
    case `class` = "class"
    case task = "task"
    case workout = "workout"
    case none = "none"
    
    static func color(_ category: String) -> Color {
        guard let eventCategory = EventCategory(rawValue: category) else { return .clear }
        return eventCategory.color        
    }
    
    var color: Color {
        switch self {
        case .meeting:
            return .red
        case .anniversary:
            return .pink
        case .vacation:
            return .green
        case .study:
            return .blue
        case .class:
            return .purple
        case .task:
            return .black
        case .workout:
            return .orange
        case .none:
            return .gray
        }
    }
}

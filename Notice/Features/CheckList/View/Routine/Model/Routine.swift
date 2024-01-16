//
//  Routine.swift
//  Notice
//
//  Created by 김민성 on 1/7/24.
//

import Foundation
import SwiftData

@Model
final class Routine {
    var title: String
    var startDate: Date
    var color: String = "#000000"
    
    @Relationship(deleteRule: .cascade)
    var performedDates: [PerformedDate]?
    
    init(
        title: String = "",
        startDate: Date = .now,
        color: String = "",
        performedDates: [PerformedDate]? = nil
    ) {
        self.title = title
        self.startDate = startDate
        self.color = color
        self.performedDates = performedDates
    }
}

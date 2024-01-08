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
    
    @Relationship(deleteRule: .cascade)
    var performedDates: [PerformedDate]?
    
    init(
        title: String = "",
        startDate: Date = .now,
        performedDates: [PerformedDate]? = nil
    ) {
        self.title = title
        self.startDate = startDate
        self.performedDates = performedDates
    }
}

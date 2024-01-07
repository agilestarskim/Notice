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
    
    @Relationship(deleteRule: .cascade)
    var performedDates: [PerformedDate]?
    
    init(title: String = "", performedDates: [PerformedDate]? = nil) {
        self.title = title
        self.performedDates = performedDates
    }
}



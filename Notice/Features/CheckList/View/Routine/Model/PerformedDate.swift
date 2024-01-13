//
//  PerformedDate.swift
//  Notice
//
//  Created by 김민성 on 1/7/24.
//

import Foundation
import SwiftData

@Model
final class PerformedDate {
    var date: String    
    var routine: Routine?
    
    init(date: String = "", routine: Routine? = nil) {
        self.date = date
        self.routine = routine
    }
}

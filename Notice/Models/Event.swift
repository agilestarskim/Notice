//
//  Schedule.swift
//  Notice
//
//  Created by 김민성 on 11/21/23.
//

import Foundation
import SwiftData

@Model
final class Event {
    var title: String = ""
    var memo: String = ""
    var category: String = "Meeting"
    var startDate: Date = Date.now
    
    init(
        title: String = "",
        memo: String = "",
        category: String = "",
        startDate: Date = Date()
    ) {
        self.title = title
        self.memo = memo
        self.category = category
        self.startDate = startDate
    }
}

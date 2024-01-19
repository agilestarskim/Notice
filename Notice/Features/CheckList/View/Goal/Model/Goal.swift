//
//  Goal.swift
//  Notice
//
//  Created by 김민성 on 1/1/24.
//

import Foundation
import SwiftData

@Model
final class Goal {
    var title: String = ""
    var emoji: Int = 0x1F3C6
    var startDate: Date = Date.now
    var endDate: Date = Date.now
    var realEndDate: Date = Date.now
    var duration: Int = 0 /* week: 0, oneMonth: 1, threeMonths: 2, year: 3, custom: 4 */
    var state: Int = 0 /* underway: 0, success: 1, failure: 2 */
    
    init(
        title: String = "",
        emoji: Int = 0x1F3C6,
        startDate: Date = .now,
        endDate: Date = .now,
        realEndDate: Date = .now,
        duration: Int = 0,
        state: Int = 0
    ) {
        self.title = title   
        self.emoji = emoji
        self.startDate = startDate
        self.endDate = endDate
        self.realEndDate = realEndDate
        self.duration = duration        
        self.state = state
    }
}

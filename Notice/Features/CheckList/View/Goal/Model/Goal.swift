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
    var title: String
    var startDate: Date
    var endDate: Date
    var duration: Int
    var image: Data?
    var state: Int /* underway: 0, success: 1, failure: 2 */
    
    init(
        title: String = "",
        startDate: Date = .now,
        endDate: Date = .distantFuture,
        duration: Int = 0,
        image: Data? = nil,
        state: Int = 0
    ) {
        self.title = title        
        self.startDate = startDate
        self.endDate = endDate
        self.duration = duration
        self.image = image
        self.state = state
    }
}

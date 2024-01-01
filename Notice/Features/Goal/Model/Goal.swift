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
    var memo: String
    var startDate: Date
    var endDate: Date
    var image: Data?
    var state: Int
    
    init(
        title: String = "",
        memo: String = "",
        startDate: Date = .now,
        endDate: Date = .distantFuture,
        image: Data? = nil,
        state: Int = 0
    ) {
        self.title = title
        self.memo = memo
        self.startDate = startDate
        self.endDate = endDate
        self.image = image
        self.state = state
    }
}

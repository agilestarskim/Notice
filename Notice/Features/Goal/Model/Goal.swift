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
    var duration: Int
    var image: Data?
    var state: Int /* onProgress: 0, success: 1, failure: 2, pending: 3 */
    
    init(
        title: String = "",
        memo: String = "",
        startDate: Date = .now,
        endDate: Date = .distantFuture,
        duration: Int = 0,
        image: Data? = nil,
        state: Int = 0
    ) {
        self.title = title
        self.memo = memo
        self.startDate = startDate
        self.endDate = endDate
        self.duration = duration
        self.image = image
        self.state = state
    }
}

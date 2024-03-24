//
//  QuickMemo.swift
//  Notice
//
//  Created by 김민성 on 2/9/24.
//

import Foundation
import SwiftData

@Model
final class QuickMemo {
    var content: String = ""
    var date: Date = Date.now
    
    init(
        content: String = "",
        date: Date = Date.now
    ) {
        self.content = content
        self.date = date
    }
}


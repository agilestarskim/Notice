//
//  SubTodo.swift
//  Notice
//
//  Created by 김민성 on 12/23/23.
//

import Foundation
import SwiftData

@Model
final class SubTodo {
    var title: String = ""
    var isDone: Bool = false
    var date: Date = Date.now
    var todo: Todo?
    
    init(
        title: String = "",
        isDone: Bool = false,
        date: Date = .now
    ) {
        self.title = title
        self.isDone = isDone
        self.date = date
    }
}

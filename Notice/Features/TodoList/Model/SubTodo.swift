//
//  SubTodo.swift
//  Notice
//
//  Created by 김민성 on 12/23/23.
//

import SwiftData

@Model
final class SubTodo {
    var title: String
    var isDone: Bool
    
    init(title: String = "", isDone: Bool = false) {
        self.title = title
        self.isDone = isDone
    }
}

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
    var todo: Todo?
    
    init(title: String = "", isDone: Bool = false, todo: Todo? = nil) {
        self.title = title
        self.isDone = isDone
        self.todo = todo
    }
}

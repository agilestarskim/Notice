//
//  Todo.swift
//  Notice
//
//  Created by 김민성 on 12/20/23.
//

import Foundation
import SwiftData

@Model
final class Todo {
    var title: String
    var memo: String
    var date: Date
    var isDone: Bool
    var flag: Bool
    
    @Relationship(deleteRule: .cascade)
    var subTodos: [SubTodo]?
    
    init(
        title: String = "",
        memo: String = "",
        date: Date = .now,
        isDone: Bool = false,
        flag: Bool = false,
        subTodos: [SubTodo]? = nil
    ) {
        self.title = title
        self.memo = memo
        self.date = date
        self.isDone = isDone
        self.flag = flag    
        self.subTodos = subTodos
    }
}


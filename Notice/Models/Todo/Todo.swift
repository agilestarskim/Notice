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
    var title: String = ""
    var memo: String = ""
    var date: Date = Date.now
    var isDone: Bool = false
    var flag: Bool = false
    
    @Relationship(deleteRule: .cascade, inverse: \SubTodo.todo)
    var subTodos: [SubTodo]? = []
    
    @Transient
    var sortedSubTodos: [SubTodo] {
        return subTodos?.sorted { $0.date < $1.date } ?? []
    }
    
    init(
        title: String = "",
        memo: String = "",
        date: Date = .now,
        isDone: Bool = false,
        flag: Bool = false,
        subTodos: [SubTodo] = []
    ) {
        self.title = title
        self.memo = memo
        self.date = date
        self.isDone = isDone
        self.flag = flag    
        self.subTodos = subTodos
    }
}

//
//  EditManager.swift
//  Notice
//
//  Created by 김민성 on 1/23/24.
//

import Foundation
import Observation

extension TodoManager {
    @Observable
    final class EditManager {
        var shouldOpenEditor: Bool = false
        var editingTodo: Todo? = nil
        
        var title: String = ""
        var memo: String = ""
        var flag: Bool = false
        var isDone: Bool = false
        var date: Date = .now
        var subTodos: [SubTodo] = []
        var subTodoTitle: String = ""
        
        var isTitleEmpty: Bool {
            title.isEmpty
        }
        
        var formTitle: String {
            editingTodo == nil ? "할 일 추가" : "할 일 편집"
        }
        
        func setData() {
            if let editingTodo {
                self.title = editingTodo.title
                self.memo = editingTodo.memo
                self.date = editingTodo.date
                self.isDone = editingTodo.isDone
                self.flag = editingTodo.flag
                self.subTodos = editingTodo.sortedSubTodos
            }
        }
        
        func resetData() {
            title = ""
            memo = ""
            flag = false
            isDone = false
            date = .now
            subTodos = []
            subTodoTitle = ""
        }
        
        func addSubTodo() {
            let subTodo = SubTodo(title: self.subTodoTitle, isDone: false, date: .now)
            self.subTodos.append(subTodo)
            self.subTodoTitle = ""
        }
        
        func deleteSubTodo(subTodo: SubTodo) {
            if let index = self.subTodos.firstIndex(of: subTodo) {
                self.subTodos.remove(at: index)
            }
        }
        
        func createNewTodo() -> Todo {
            return Todo(
                title: title,
                memo: memo,
                date: date,
                isDone: isDone,
                flag: flag,
                subTodos: subTodos
            )
        }
    }
}

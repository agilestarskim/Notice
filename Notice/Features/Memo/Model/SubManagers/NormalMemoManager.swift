//
//  MemoEditorManager.swift
//  Notice
//
//  Created by 김민성 on 2/9/24.
//

import Observation
import SwiftData
import SwiftUI

extension MemoManager {
    @Observable
    final class NormalMemoManager {        
        private let context: ModelContext
        private let appState: AppState
        
        var memos: [Memo] = []        
        var editingMemo: Memo?
        var selectedFolder: Folder?
        
        init(context: ModelContext, appState: AppState) {
            self.context = context
            self.appState = appState
        }
        
        func openMemo(_ memo: Memo) {
            editingMemo = memo
        }
        
        func fetch() {            
            guard let id = selectedFolder?.persistentModelID else { return }
            let predicate = #Predicate<Folder> { folder in
                folder.persistentModelID == id
            }
            guard let fetched = try? context.fetch(FetchDescriptor<Folder>(predicate: predicate)) else { return }
            self.memos = fetched.first?.memos ?? []          
        }
        
        func create() -> Memo {
            let newMemo = Memo(title: "New Memo", content: "", date: .now)
            selectedFolder?.memos.append(newMemo)            
            return newMemo
        }
        
        func delete(_ memo: Memo) {
            context.delete(memo)
        }
        
        func changeLastAccessDate(_ memo: Memo) {
            memo.date = .now
        }
    }
}

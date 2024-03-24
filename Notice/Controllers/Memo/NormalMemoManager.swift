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
        
        private var _memos: [Memo] = []
        var editingMemo: Memo?
        var selectedFolder: Folder?
        
        var memos: [Memo] {
            _memos.sorted {
                if $0.pin == $1.pin {
                    return $0.date > $1.date
                } else {
                    return $0.pin > $1.pin
                }
            }
        }
        
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
            
            self._memos = fetched.first?.memos ?? []
        }
        
        func create() -> Memo {
            let newMemo = Memo(title: "New Memo", content: "", date: .now)
            selectedFolder?.memos?.append(newMemo)            
            return newMemo
        }
        
        func delete(_ memo: Memo) {
            context.delete(memo)
        }
        
        func changeLastAccessDate(_ memo: Memo) {
            memo.date = .now
        }
        
        func togglePin(_ memo: Memo) {
            memo.pin.toggle()
        }
    }
}

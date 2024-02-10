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
        var shouldOpenMemoEditor: Bool = false
        var editingMemo: Memo?
        var folder: Folder?
        
        init(context: ModelContext, appState: AppState) {
            self.context = context
            self.appState = appState
        }
        
        func onAppear(_ folder: Folder) {
            appState.onTapPlusButton = self.onTapPlusButton
            self.folder = folder
        }
        
        private func onTapPlusButton() {
            let newMemo = Memo(title: "New Memo", content: "", date: .now)
            editingMemo = newMemo
            
            create(newMemo)
        }
        
        func create(_ memo: Memo) {
            folder?.momos.append(memo)
        }
        
        
    }
}

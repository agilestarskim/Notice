//
//  QuickMemoManager.swift
//  Notice
//
//  Created by 김민성 on 2/9/24.
//

import Observation
import SwiftData
import SwiftUI

extension MemoManager {
    @Observable
    final class QuickMemoManager {
        private let context: ModelContext
        private let appState: AppState
        
        var quickMemos: [QuickMemo] = []
        var quickMemoCount: Int = 0
        
        var editingQuickMemo: QuickMemo?
        
        var quickMemoText: String = ""        
        var savingAnimation: Bool = false
        
        init(context: ModelContext, appState: AppState) {
            self.context = context
            self.appState = appState
        }
        
        func fetchCount() {
            do {
                quickMemoCount = try context.fetchCount(FetchDescriptor<QuickMemo>())
            } catch {
                quickMemoCount = 0
            }
        }
        
        func fetch() {
            let sort = [SortDescriptor(\QuickMemo.date, order: .reverse)]
            
            do {
                quickMemos = try context.fetch(FetchDescriptor(sortBy: sort))
                quickMemoCount = quickMemos.count
            } catch {
                quickMemos = []
            }
        }
        
        func openQuickMemo(_ quickMemo: QuickMemo) {
            editingQuickMemo = quickMemo
        }
        
        func exitQuickMemoView() {
            editingQuickMemo = nil
        }
        
        func resetQuickMemo() {
            quickMemoText = ""
        }
        
        func changeLastAccessDate(_ quickMemo: QuickMemo) {
            quickMemo.date = .now
        }
        
        @discardableResult
        func createQuickMemo() -> QuickMemo {
            let quickMemo = QuickMemo(content: quickMemoText)
            context.insert(quickMemo)
            return quickMemo
        }
        
        func delete(_ quickMemo: QuickMemo) {
            context.delete(quickMemo)
        }
        
        func turnOnSavingAnimation() {
            savingAnimation.toggle()
        }
        
        func move(_ memo: QuickMemo, to folder: Folder) {
            let newMemo = Memo(title: "New Memo", content: memo.content, date: .now)
            folder.memos.append(newMemo)
        }
    }
}


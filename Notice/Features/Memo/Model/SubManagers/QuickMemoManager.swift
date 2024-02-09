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
        var quickMemoText: String = ""
        var quickMemos: [QuickMemo] = []
        var quickMemoCount: Int = 0
        
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
            } catch {
                quickMemos = []
            }
        }
        
        func onAppearList() {
            fetch()
        }        
        
        func resetQuickMemo() {
            quickMemoText = ""
        }
        
        func createQuickMemo() {
            let quickMemo = QuickMemo(content: quickMemoText)
            context.insert(quickMemo)
        }        
        
        func delete(_ quickMemo: QuickMemo) {
            context.delete(quickMemo)
        }
    }
}


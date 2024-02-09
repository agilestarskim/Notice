//
//  MemoManager.swift
//  Notice
//
//  Created by 김민성 on 2/9/24.
//

import Foundation
import Observation
import SwiftData

@Observable
final class MemoManager {
    let appState: AppState
    let context: ModelContext
    let formatter: NTFormatter
    let calendar: Calendar
    
    let editManager: EditManager
    let folderManager: FolderManager
    let quickMemoManager: QuickMemoManager
    
    init(
        appState: AppState,
        context: ModelContext,
        formatter: NTFormatter = NTFormatter.shared,
        calendar: Calendar = Calendar.autoupdatingCurrent
    ) {
        self.appState = appState
        self.context = context
        self.formatter = formatter
        self.calendar = calendar
        
        self.editManager = MemoManager.EditManager()
        self.folderManager = MemoManager.FolderManager(context: context)
        self.quickMemoManager = MemoManager.QuickMemoManager(context: context, appState: appState)
    }
    var folders: [Folder] {
        folderManager.folders
    }    
    
    var quickMemos: [QuickMemo] {
        quickMemoManager.quickMemos
    }
    
    func onAppear() {
        appState.onTapPlusButton = onTapPlusButton
        quickMemoManager.fetchCount()
    }
    
    private func onTapPlusButton() {
        folderManager.shouldOpenFolderEditor = true
    }
    
    func onTapFolderEditDoneButton() {
        folderManager.create()
        folderManager.resetData()
        folderManager.fetch()
        folderManager.shouldOpenFolderEditor = false
    }
    
    func onTapQuickMemoSaveButton() {
        quickMemoManager.createQuickMemo()
        quickMemoManager.fetchCount()
        quickMemoManager.resetQuickMemo()        
        appState.showToast("저장되었습니다")
    }
    
    func onTapQuickMemoDeleteButton(_ quickMemo: QuickMemo) {
        quickMemoManager.delete(quickMemo)
        quickMemoManager.fetch()
        appState.showToast("삭제되었습니다")
    }
    
    
    
}

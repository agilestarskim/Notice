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
    
    let normalMemoManager: NormalMemoManager
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
        
        self.normalMemoManager = NormalMemoManager(context: context, appState: appState)
        self.folderManager = FolderManager(context: context)
        self.quickMemoManager = QuickMemoManager(context: context, appState: appState)
    }
    var folders: [Folder] {
        folderManager.folders
    }    
    
    var quickMemos: [QuickMemo] {
        quickMemoManager.quickMemos
    }
    
    var normalMemos: [Memo] {
        normalMemoManager.memos
    }
    
    var quickMemoAnimation: Bool {
        quickMemoManager.savingAnimation
    }
    
    // MARK: - Home
    func onAppear() {
        appState.onTapPlusButton = openFolderEditor
        quickMemoManager.fetchCount()
    }
    
    private func openFolderEditor() {
        folderManager.shouldOpenFolderEditor = true
    }
    
    func onTapFolderEditDoneButton() {
        folderManager.create()
        folderManager.resetData()
        folderManager.fetch()
        folderManager.shouldOpenFolderEditor = false
    }
    
    func onTapQuickMemoSaveButton() {
        if quickMemoManager.quickMemoText.isEmpty { return }
        quickMemoManager.createQuickMemo()
        quickMemoManager.fetchCount()
        quickMemoManager.resetQuickMemo()       
        quickMemoManager.turnOnSavingAnimation()
        appState.showToast("저장되었습니다")
    }
    
    func onTapFolderDeleteButton(_ folder: Folder) {
        folderManager.delete(folder)
        folderManager.fetch()
        appState.showToast("삭제되었습니다")
    }
    
    func displayFolderTitle(_ folder: Folder) -> String {
        folderManager.displayTitle(folder)
    }
    
    // MARK: - Quick Memo
    func onAppearQuickMemoListView() {
        appState.onTapPlusButton = openNewQuickMemo
        quickMemoManager.fetch()
    }
    
    func openNewQuickMemo() {
        let quickMemo = quickMemoManager.createQuickMemo()
        quickMemoManager.openQuickMemo(quickMemo)
    }
    
    func onAppearQuickMemoView(_ quickMemo: QuickMemo) {
        appState.hideTab()
        quickMemoManager.changeLastAccessDate(quickMemo)
    }
    
    func onDisappearQuickMemoView(_ quickMemo: QuickMemo) {
        appState.showTab()
        if quickMemo.content.isEmpty {
            quickMemoManager.delete(quickMemo)
            quickMemoManager.fetch()
        }
        onAppear()
    }
    
    func onTapQuickMemoDeleteButton(_ quickMemo: QuickMemo) {
        quickMemoManager.delete(quickMemo)
        quickMemoManager.fetch()
        appState.showToast("삭제되었습니다")
    }
    
    func onTapMoveButton(_ quickMemo: QuickMemo, folder: Folder) {
        quickMemoManager.move(quickMemo, to: folder)
        quickMemoManager.delete(quickMemo)            
        appState.showToast("\(folder.title)로 이동되었습니다")
    }
    
    // MARK: - Normal Memo
    func onAppearNormalMemoListView(at folder: Folder) {
        appState.onTapPlusButton = openNewNormalMemo
        normalMemoManager.selectedFolder = folder
        normalMemoManager.fetch()        
    }
    
    func openNewNormalMemo() {
        let memo = normalMemoManager.create()
        normalMemoManager.openMemo(memo)
    }
    
    func onAppearNormalMemoView(_ memo: Memo) {
        appState.hideTab()
        normalMemoManager.changeLastAccessDate(memo)
    }

    func onDisappearNormalMemoView(_ memo: Memo) {
        appState.showTab()
        if memo.content.isEmpty {
            normalMemoManager.delete(memo)
            normalMemoManager.fetch()
        }
    }
    
    func onTapNormalMemoDeleteButton(_ memo: Memo) {
        normalMemoManager.delete(memo)
        normalMemoManager.fetch()
        appState.showToast("삭제되었습니다")
    }
    
    func onTapPinButton(_ memo: Memo) {
        normalMemoManager.togglePin(memo)
        normalMemoManager.fetch()
    }
}

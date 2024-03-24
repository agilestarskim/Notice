//
//  MemoFolderManagers.swift
//  Notice
//
//  Created by 김민성 on 2/9/24.
//

import Observation
import SwiftData
import SwiftUI

extension MemoManager {
    @Observable
    final class FolderManager {
        private let context: ModelContext
        var folders: [Folder] = []
        
        var folderTitle: String = ""
        var folderEmoji: Int = 0x1F3C6
        
        var shouldOpenFolderEditor: Bool = false
        
        init(context: ModelContext) {
            self.context = context
        }
        
        func onAppear() {
            fetch()
        }
        
        func fetch() {
            let sort = [SortDescriptor(\Folder.date)]
            var fetchDescriptor = FetchDescriptor<Folder>(sortBy: sort)
            fetchDescriptor.propertiesToFetch = [\.title, \.emoji]
            do {
                folders = try context.fetch(FetchDescriptor(sortBy: sort))
            } catch {
                folders = []
            }
        }
        
        func create() {
            let folder = Folder(
                title: folderTitle,
                emoji: folderEmoji,
                date: .now,
                memos: []
            )
            context.insert(folder)            
        }
        
        func delete(_ folder: Folder) {
            context.delete(folder)
        }
        
        func resetData() {
            folderTitle = ""
            folderEmoji = 0x1F3C6
        }
        
        func displayTitle(_ folder: Folder) -> String {
            return folder.emoji.emoji + "  " + folder.title
        }
    }
}

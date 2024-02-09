//
//  Folder.swift
//  Notice
//
//  Created by 김민성 on 2/9/24.
//

import Foundation
import SwiftData

@Model
final class Folder {
    var title: String = ""
    var emoji: Int = 0x1F3C6
    var date: Date = Date.now
    @Relationship(deleteRule: .cascade, inverse: \Memo.folder)
    var momos: [Memo] = []
    
    init(
        title: String = "",
        emoji: Int = 0x1F3C6,
        date: Date = Date.now,
        memos: [Memo] = []
    ) {
        self.title = title
        self.emoji = emoji
        self.date = date
        self.momos = memos
    }
}

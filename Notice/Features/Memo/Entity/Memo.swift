//
//  Memo.swift
//  Notice
//
//  Created by 김민성 on 2/9/24.
//

import Foundation
import SwiftData

@Model
final class Memo {
    var title: String = ""
    var content: String = ""
    var date: Date = Date.now
    var folder: Folder?
    
    init(
        title: String = "",
        content: String = "",
        date: Date = Date.now
    ) {
        self.title = title
        self.content = content
        self.date = date        
    }
}


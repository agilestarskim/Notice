//
//  Folder.swift
//  Notice
//
//  Created by 김민성 on 2/9/24.
//

import Foundation
import SwiftData

@Model
final class Folder: Codable {
    var title: String = ""
    var emoji: Int = 0x1F3C6
    var date: Date = Date.now
    @Relationship(deleteRule: .cascade, inverse: \Memo.folder)
    var memos: [Memo]? = []
    
    init(
        title: String = "",
        emoji: Int = 0x1F3C6,
        date: Date = Date.now,
        memos: [Memo] = []
    ) {
        self.title = title
        self.emoji = emoji
        self.date = date
        self.memos = memos
    }
    
    enum CodingKeys: CodingKey {
        case title, emoji, date, memos
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        emoji = try container.decode(Int.self, forKey: .emoji)
        date = try container.decode(Date.self, forKey: .date)
        memos = try container.decode([Memo].self, forKey: .memos)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(emoji, forKey: .emoji)
        try container.encode(date, forKey: .date)
        try container.encode(memos, forKey: .memos)        
    }
}

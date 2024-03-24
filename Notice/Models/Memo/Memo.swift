//
//  Memo.swift
//  Notice
//
//  Created by 김민성 on 2/9/24.
//

import Foundation
import SwiftData

@Model
final class Memo: Codable {
    var title: String = ""
    var content: String = ""
    var date: Date = Date.now
    var pin: Bool = false
    var folder: Folder?
    
    init(
        title: String = "",
        content: String = "",
        date: Date = Date.now,
        pin: Bool = false
    ) {
        self.title = title
        self.content = content
        self.date = date        
        self.pin = pin
    }
    
    enum CodingKeys: CodingKey {
        case title, content, date, pin, folder
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        content = try container.decode(String.self, forKey: .content)
        date = try container.decode(Date.self, forKey: .date)
        pin = try container.decode(Bool.self, forKey: .pin)
        folder = try container.decode(Folder.self, forKey: .folder)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(content, forKey: .content)
        try container.encode(date, forKey: .date)
        try container.encode(pin, forKey: .pin)
        try container.encode(folder, forKey: .folder)
    }
}


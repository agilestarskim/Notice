//
//  Item.swift
//  Notice
//
//  Created by 김민성 on 12/20/23.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}

//
//  Int+toEmoji.swift
//  Notice
//
//  Created by 김민성 on 1/20/24.
//

import Foundation

extension Int {
    var emoji: String {
        if let scalar = UnicodeScalar(self) {
            return String(scalar)
        } else {
            return ""
        }
    }
}

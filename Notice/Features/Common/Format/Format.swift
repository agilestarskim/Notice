//
//  Format.swift
//  Notice
//
//  Created by 김민성 on 12/4/23.
//

import Foundation

final class Format {
    static let shared = Format()
    
    private let formatter = DateFormatter()
    
    private init() {
        formatter.locale = Locale.current
        formatter.timeZone = .current
    }
    
    func yearMonth(_ date: Date) -> String {
        formatter.dateFormat = "yyyy.MM"
        return formatter.string(from: date)
    }
    
    func yearMonthDay(_ date: Date) -> String {
        formatter.dateFormat = "yyyy.MM.dd (E)"
        return formatter.string(from: date)
    }
    
    func day(_ date: Date) -> String {
        formatter.dateFormat = "M.d (E)"
        return formatter.string(from: date)
    }
    
    func time(_ date: Date) -> String {
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: date)
    }
}

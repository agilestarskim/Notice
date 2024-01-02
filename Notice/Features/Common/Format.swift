//
//  Format.swift
//  Notice
//
//  Created by 김민성 on 12/4/23.
//

import Foundation

final class Format {
    static let shared = Format()
    
    private lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        
        formatter.locale = Locale.current
        formatter.timeZone = .current
        
        return formatter
    }()
    
    func string(_ date: Date, style formatStyle: NoticeFormatStyle) -> String {
        if date.isForever { return "-" }
        formatter.dateFormat = formatStyle.rawValue
        return formatter.string(from: date)
    }
    
    enum NoticeFormatStyle: String {
        case yyyyMM = "yyyy.MM"
        case yyyyMMdd = "yyyy.MM.dd"
        case yyyyMMddE = "yyyy.MM.dd (E)"
        case MdE = "M.d (E)"
        case hmma = "h:mm a"
    }
}

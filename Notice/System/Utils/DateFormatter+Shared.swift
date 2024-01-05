//
//  Format.swift
//  Notice
//
//  Created by 김민성 on 12/4/23.
//

import Foundation

extension DateFormatter {
    static private let shared: DateFormatter = {
        let formatter = DateFormatter()
        
        formatter.locale = Locale.current
        formatter.timeZone = .current
        
        return formatter
    }()
    
    static func string(_ date: Date, style formatStyle: NoticeFormatStyle) -> String {
        if date.isForever { return "-" }
        shared.dateFormat = formatStyle.rawValue
        return shared.string(from: date)
    }
    
    enum NoticeFormatStyle: String {
        case yyyyMM = "yyyy.MM"
        case yyyyMMdd = "yyyy.MM.dd"
        case yyyyMMddE = "yyyy.MM.dd (E)"
        case MdE = "M.d (E)"
        case hmma = "h:mm a"
    }
}

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
    
    static func string(_ date: Date, style formatStyle: NTFormatStyle) -> String {
        if date.isForever { return "-" }
        shared.dateFormat = formatStyle.rawValue
        return shared.string(from: date)
    }
    
    enum NTFormatStyle: String {
        case yyyyMM = "yyyy.MM"
        case yyyyMMdd = "yyyy.MM.dd"
        case yyyyMd = "yyyy.M.d"
        case yyyyMMddE = "yyyy.MM.dd (E)"
        case MdE = "M.d (E)"
        case hmma = "h:mm a"
        
        case performedDate = "yyMMdd"
    }
}

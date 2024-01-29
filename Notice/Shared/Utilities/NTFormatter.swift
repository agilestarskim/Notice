//
//  Formatter.swift
//  Notice
//
//  Created by 김민성 on 1/23/24.
//

import Foundation

final class NTFormatter {
    static let shared = NTFormatter()
    
    private init() {}
    
    private let formatter: DateFormatter = {
        let formatter = DateFormatter()
        
        formatter.locale = Locale.current
        formatter.timeZone = .current
        
        return formatter
    }()
    
    func string(_ date: Date, style formatStyle: NTFormatStyle) -> String {
        formatter.dateFormat = formatStyle.rawValue
        return formatter.string(from: date)
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

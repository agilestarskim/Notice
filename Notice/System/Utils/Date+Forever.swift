//
//  Date+Forever.swift
//  Notice
//
//  Created by 김민성 on 1/5/24.
//

import Foundation

extension Date {
    static var forever: Self {
        let calendar: Calendar = {
            var calendar = Calendar.current
            calendar.locale = .current
            calendar.timeZone = .current
            return calendar
        }()
                
        var dateComponents = DateComponents()
        dateComponents.year = 4000
        
        return calendar.date(from: dateComponents) ?? .distantFuture
    }
    
    var isForever: Bool {
        let calendar: Calendar = {
            var calendar = Calendar.current
            calendar.locale = .current
            calendar.timeZone = .current
            return calendar
        }()
        
        return calendar.isDate(self, inSameDayAs: .forever)
    }
}

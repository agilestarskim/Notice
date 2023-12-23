//
//  Date+.swift
//  Notice
//
//  Created by 김민성 on 12/17/23.
//

import Foundation

extension Date {
    func startOfMonth() -> Date {
        let calendar = Calendar.current
        return calendar.date(
            from: calendar.dateComponents([.year, .month], from: self)
        ) ?? self
    }
    
    func stripTime() -> Date{
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: self)
        return calendar.date(from: components) ?? self
    }
}

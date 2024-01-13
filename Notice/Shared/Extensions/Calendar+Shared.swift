//
//  SystemCalendar.swift
//  Notice
//
//  Created by 김민성 on 1/5/24.
//

import Foundation

extension Calendar {
    static let shared: Self = {
        var calendar = Self.current
        calendar.locale = .current
        calendar.timeZone = .current
        return calendar
    }()
}

//
//  Bool+Comparable.swift
//  Notice
//
//  Created by 김민성 on 1/7/24.
//

extension Bool: Comparable {
    public static func <(lhs: Self, rhs: Self) -> Bool {
        // false < true 일 때만 true
        !lhs && rhs
    }
}

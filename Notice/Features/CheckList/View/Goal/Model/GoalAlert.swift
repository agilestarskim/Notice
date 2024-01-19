//
//  GoalAlert.swift
//  Notice
//
//  Created by 김민성 on 1/18/24.
//

import Foundation

struct GoalAlert: Identifiable {
    enum AlertType {
        case delete
        case succeed
        case fail
        case retry
        case cancelSuccess
    }

    let id: AlertType
    let title: String
    let message: String
}

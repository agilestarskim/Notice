//
//  GoalState.swift
//  Notice
//
//  Created by 김민성 on 1/1/24.
//

enum GoalFilter: String, CaseIterable {
    case underway = "Underway"
    case success = "Success"
    case failure = "Failure"
    
    var index: Int {
        switch self {
        case .underway:
            1
        case .success:
            2
        case .failure:
            3
        }
    }
}

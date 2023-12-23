//
//  AppState.swift
//  Notice
//
//  Created by 김민성 on 12/2/23.
//

import Observation

@Observable
final class AppState {
    var tab: Tabs = .calendar
    var theme: Theme = Dawn()
    
    @ObservationIgnored
    var onTapPlusButton: () -> Void = {}
}

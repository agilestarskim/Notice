//
//  AppState.swift
//  Notice
//
//  Created by 김민성 on 12/2/23.
//

import Observation
import CoreFoundation

@Observable
final class AppState {
    var tab: Tabs = .calendar
    var theme: Theme = Dawn()
    var toastMessage: String = ""
    var shouldToastOn: Bool = false
    
    @ObservationIgnored
    var onTapPlusButton: (() -> Void)?
    
    @ObservationIgnored
    let tabHeight = 56.0
    
    @ObservationIgnored
    var bottomSafeAreaPadding: CGFloat {
        tabHeight + 14.0
    }
    
    func showToast(_ message: String) {
        toastMessage = message
        shouldToastOn = true
    }
}

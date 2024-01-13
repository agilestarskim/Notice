//
//  PickerManager.swift
//  Notice
//
//  Created by 김민성 on 1/13/24.
//

import SwiftUI

final class PickerManager: ObservableObject {
    @Published var checkTab: CheckTab = .todo
    @Published var goingRight: Bool = false
    
    func setTabDirection(prevTab: CheckTab, currentTab: CheckTab) {        
        if prevTab.index - currentTab.index < 0 {
            self.goingRight = true            
        } else {
            self.goingRight = false
        }
    }
}


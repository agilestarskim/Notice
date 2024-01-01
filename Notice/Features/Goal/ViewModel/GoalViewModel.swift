//
//  GoalViewModel.swift
//  Notice
//
//  Created by 김민성 on 1/1/24.
//

import SwiftData
import SwiftUI

final class GoalViewModel: ObservableObject {
    @Published var goals: [Goal] = []
    @Published var filter: GoalFilter = .onProgress
    @Published var viewMode: GoalViewMode = .collection
    
    private let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
        fetchGoals()
    }
    
    func fetchGoals() {
        
    }
    
    var viewModeButtonImage: String {
        if viewMode == .collection {
            return "line.3.horizontal"
        } else {
            return "rectangle.grid.2x2"
        }
    }
}


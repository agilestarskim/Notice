//
//  LaneCardView.swift
//  Notice
//
//  Created by 김민성 on 1/1/24.
//

import SwiftUI

struct LaneCardView: View {    
    @Environment(AppState.self) private var appState
    let goal: Goal
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(appState.theme.container)
            .frame(width: 200, height: 150)   
            .overlay {
                VStack {
                    Text(goal.title)                    
                }
                .foregroundStyle(appState.theme.primary)
            }
    }
}

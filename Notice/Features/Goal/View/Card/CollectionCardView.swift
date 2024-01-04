//
//  CollectionCardView.swift
//  Notice
//
//  Created by 김민성 on 1/1/24.
//

import SwiftUI

struct CollectionCardView: View {
    @Environment(AppState.self) private var appState
    let goal: Goal
    
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(appState.theme.container)
            .frame(height: 150)   
            .overlay {
                VStack {
                    Text(goal.title)
                    Text(goal.memo)
                }
                .foregroundStyle(appState.theme.primary)
            }
    }
}

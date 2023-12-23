//
//  TabViewIcon.swift
//  Notice
//
//  Created by 김민성 on 11/6/23.
//

import SwiftUI

struct TabIcon: View {
    @Environment(AppState.self) private var appState
    let tab: Tabs
    
    var isSelected: Bool {
        self.tab == self.appState.tab
    }
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: tab.image)
                .aspectRatio(contentMode: .fit)
            Text(tab.label)
                .font(.caption2)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
        }
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
        .foregroundStyle(isSelected ? appState.theme.primary: appState.theme.secondary)
        .onTapGesture {
            appState.tab = tab
        }        
    }
}

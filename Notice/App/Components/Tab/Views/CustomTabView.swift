//
//  CustomTabView.swift
//  Notice
//
//  Created by 김민성 on 11/6/23.
//

import SwiftUI

struct CustomTabView: View {
    @Environment(AppState.self) private var appState
    
    let columns = Array(repeating: GridItem(spacing: 0, alignment: .bottom), count: 5)
    var body: some View {
        LazyVGrid(columns: columns, spacing: 0) {
            TabIcon(tab: .calendar)
            TabIcon(tab: .check)
            PlusButton()
            TabIcon(tab: .memo)
            TabIcon(tab: .data)
        }
        .padding(.horizontal, 10)
        .padding(.top, 10)
        .background(appState.theme.container)
    }
    
    func PlusButton() -> some View {
        Button {
            appState.onTapPlusButton()
        } label: {
            Image(systemName: "plus")
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundStyle(.black)
                .padding(12)
                .background {
                    Circle()
                        .fill(.white)
                }
        }
        .shadow(color: appState.theme.accent, radius: 5)
    }
}

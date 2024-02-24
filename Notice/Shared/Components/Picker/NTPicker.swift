//
//  NTPicker.swift
//  Notice
//
//  Created by 김민성 on 1/6/24.
//

import SwiftUI

struct NTPicker<Tab>: View where
    Tab: Hashable & RawRepresentable,
    Tab.RawValue: StringProtocol,
    Tab: CaseIterable,
    Tab: Identifiable,
    Tab.AllCases: RandomAccessCollection
{
    @Environment(AppState.self) private var appState
    @Binding var tab: Tab
    var body: some View {
        HStack {
            ForEach(Tab.allCases) { tab in
                if self.tab == tab {
                    TabButton(tab: tab)
                    .buttonStyle(.borderedProminent)
                    .tint(appState.theme.container)
                } else{
                    TabButton(tab: tab)
                    .buttonStyle(.bordered)
                }
            }
        }
        .padding(.horizontal)
    }
    
    func TabButton(tab: Tab) -> some View {
        Button {
            withAnimation {
                self.tab = tab
            }
        } label: {
            Text(tab.rawValue)
                .minimumScaleFactor(0.3)
                .lineLimit(1)
                .foregroundStyle(appState.theme.primary)
                .frame(maxWidth: .infinity)
        }
    }
}

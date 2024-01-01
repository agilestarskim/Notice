//
//  PendingCard.swift
//  Notice
//
//  Created by 김민성 on 1/1/24.
//

import SwiftUI

struct PendingCardView: View {
    @Environment(AppState.self) private var appState
    
    var body: some View {
        VStack {
            HStack {
                Circle()
                    .fill(appState.theme.secondary)
                    .frame(width: 44, height: 44)
                VStack(alignment: .leading) {
                    Text("Title")
                        .bold()
                        .foregroundStyle(appState.theme.primary)
                    Text("This is the memo")
                        .foregroundStyle(appState.theme.secondary)
                    Text("종료시점부터 10일 경과")
                        .foregroundStyle(appState.theme.secondary)
                }
                Spacer()
            }
            .padding()
            
            HStack {
                Button {
                    
                } label: {
                    Text("실패")
                        .frame(maxWidth: .infinity)
                }
                .tint(appState.theme.secondary)
                .buttonStyle(.borderedProminent)
                Button {
                    
                } label: {
                    Text("재도전")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                
                Button {
                    
                } label: {
                    Text("성공")
                        .frame(maxWidth: .infinity)
                }
                .tint(appState.theme.accent)
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
        .background(appState.theme.container)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

//
//  PendingCard.swift
//  Notice
//
//  Created by 김민성 on 1/1/24.
//

import SwiftUI

struct PendingCardView: View {
    @Environment(AppState.self) private var appState
    let goal: Goal
    
    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 20) {
                
                
                VStack(alignment: .leading) {
                    Text(goal.title)
                        .font(.title3)
                        .bold()                    
                    Spacer()
                    Text("종료: \(DateFormatter.string(goal.endDate, style: .yyyyMMdd))")
                }
                .foregroundStyle(appState.theme.primary)
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

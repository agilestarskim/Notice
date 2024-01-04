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
                GoalImage
                    .frame(height: 130)
                    .aspectRatio(3/4, contentMode: .fit)
                
                VStack(alignment: .leading) {
                    Text(goal.title)
                        .font(.title3)
                        .bold()
                    Text(goal.memo)
                        .lineLimit(1)
                    Spacer()
                    Text("종료: \(Format.shared.string(goal.endDate, style: .yyyyMMdd))")
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
    
    var GoalImage: some View {
        ZStack {
            if let imageData = goal.image {
                Image(uiImage: UIImage(data: imageData) ?? .init())
                    .resizable()
                    .aspectRatio(3/4, contentMode: .fill)
            } else {
                Image(uiImage: UIImage(resource: .test))
                    .resizable()
                    .aspectRatio(3/4, contentMode: .fill)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

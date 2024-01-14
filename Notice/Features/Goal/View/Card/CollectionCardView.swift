//
//  CollectionCardView.swift
//  Notice
//
//  Created by 김민성 on 1/1/24.
//

import SwiftUI

struct CollectionCardView: View {
    @Environment(AppState.self) private var appState
    @EnvironmentObject private var vm: GoalManager
    let goal: Goal
    
    var body: some View {
        VStack {
            if vm.filter == .underway {
                OnProgress
            } else {
                SuccessAndFailure
            }
        }
        .background(appState.theme.container)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
    var OnProgress: some View {
        HStack(alignment: .top, spacing: 20) {
            GoalImage
                .frame(height: 130)
                .aspectRatio(3/4, contentMode: .fit)
            
            VStack(alignment: .leading) {
                Text(goal.title)
                    .font(.title3)
                    .bold()
                Spacer()
                Text("시작한지 \("") 일")
                Text("종료까지 \("") 일")
            }
            .foregroundStyle(appState.theme.primary)
            Spacer()
        }
        .padding()
    }
    
    var SuccessAndFailure: some View {
        ZStack {
            GoalImage
                .blur(radius: 2)
            appState.theme.container.opacity(0.6)
            
            VStack {
                Spacer()
                Text(goal.title)
                    .font(.title2)
                    .bold()
                Spacer()
                Text("기간: \("")일")
            }
            .padding()
            .foregroundStyle(appState.theme.primary)
        }
        .aspectRatio(3/4, contentMode: .fit)
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

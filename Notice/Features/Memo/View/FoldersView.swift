//
//  FoldersView.swift
//  Notice
//
//  Created by 김민성 on 2/9/24.
//

import SwiftUI

struct FoldersView: View {
    @Environment(AppState.self) private var appState
    @Environment(MemoManager.self) private var memoManager
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Folders")
                    .font(.title2)
                    .foregroundStyle(appState.theme.primary)
                Spacer()
            }
            .padding(.horizontal)
            
            List {
                QuickMemos
                Folders
            }            
            .scrollIndicators(.hidden)
            .scrollContentBackground(.hidden)
        }
        .onAppear(perform: memoManager.folderManager.onAppear)
    }
    
    var QuickMemos: some View {
        NavigationLink {
            QuickMemoListView()
        } label: {
            HStack {
                Text("⚡️")
                Text("Quick Memos")
                
                Spacer()
                
                Text("\(memoManager.quickMemoManager.quickMemoCount)")
                    .foregroundStyle(appState.theme.secondary)
            }
            .foregroundStyle(appState.theme.primary)
        }
        .listRowBackground(appState.theme.container)
    }
    
    var Folders: some View {
        ForEach(memoManager.folders) { folder in
            NavigationLink {
                MemoListView(memos: folder.momos)
            } label: {
                HStack {
                    Text(folder.emoji.emoji)
                    Text(folder.title)
                    
                    Spacer()
                    
                    Text("\(folder.momos.count)")
                        .foregroundStyle(appState.theme.secondary)
                }
                .foregroundStyle(appState.theme.primary)
            }
            .listRowBackground(appState.theme.container)
        }
    }
}

#Preview {
    FoldersView()
        .padding()
        .background(AppState().theme.background)
        .environment(AppState())
}

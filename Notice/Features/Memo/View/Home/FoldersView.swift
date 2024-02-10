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
                QuickMemosFolder
                NormalMemosFolders
            }
            .listRowSpacing(10)
            .scrollIndicators(.hidden)
            .scrollContentBackground(.hidden)
        }
        .navigationDestination(for: Folder.self) { folder in
            NormalMemoListView(folder: folder)
        }
        .navigationDestination(for: Bool.self) { _ in
            QuickMemoListView()
        }
        .onAppear(perform: memoManager.folderManager.onAppear)
    }
    
    var QuickMemosFolder: some View {
        NavigationLink(value: true) {
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
    
    var NormalMemosFolders: some View {
        ForEach(memoManager.folders) { folder in
            NavigationLink(value: folder) {
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

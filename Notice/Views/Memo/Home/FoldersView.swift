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
                    .font(.title.bold())                    
                    .foregroundStyle(appState.theme.primary)
                    .padding(.horizontal)
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
            HStack(spacing: 10) {
                Image(systemName: "bolt.fill")
                    .renderingMode(.original)
                    .symbolEffect(.bounce, options: .repeat(3).speed(1.5), value: memoManager.quickMemoAnimation)
                    .imageScale(.large)
                Text("Quick Memos")
                
                Spacer()
                
                Text("\(memoManager.quickMemoManager.quickMemoCount)")
                    .foregroundStyle(appState.theme.secondary)
                    .transition(.scale)
            }
            .foregroundStyle(appState.theme.primary)
            .animation(.bouncy, value: memoManager.quickMemoManager.quickMemoCount)
        }
        .listRowBackground(appState.theme.container)        
    }
    
    var NormalMemosFolders: some View {
        ForEach(memoManager.folders) { folder in
            NavigationLink(value: folder) {
                HStack {
                    Text(memoManager.displayFolderTitle(folder))
                    
                    Spacer()
                    
                    Text("\(folder.memos?.count ?? 0)")
                        .foregroundStyle(appState.theme.secondary)
                }
                .foregroundStyle(appState.theme.primary)
            }
            .listRowBackground(appState.theme.container)
            .swipeActions(edge: .trailing) {
                Button("Delete") {                    
                    memoManager.onTapFolderDeleteButton(folder)
                }
                .tint(.red)
            }
        }
    }
}

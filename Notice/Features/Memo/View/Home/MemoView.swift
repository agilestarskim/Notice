//
//  MemoView.swift
//  Notice
//
//  Created by 김민성 on 11/6/23.
//

import SwiftUI

struct MemoView: View {
    @Environment(AppState.self) private var appState
    @Environment(MemoManager.self) private var memoManager
    var body: some View {
        @Bindable var folderManager = memoManager.folderManager
        NavigationStack {
            VStack(spacing: 14) {
                QuickMemoEditView()
                    .padding()
                FoldersView()
            }
            .background(appState.theme.background)
            .sheet(isPresented: $folderManager.shouldOpenFolderEditor) {
                FolderEditView()
            }
        }
        .onAppear(perform: memoManager.onAppear)
    }
}

#Preview {
    MemoView()
        .environment(AppState())
}

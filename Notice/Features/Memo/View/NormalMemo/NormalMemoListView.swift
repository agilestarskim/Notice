//
//  MemoListView.swift
//  Notice
//
//  Created by 김민성 on 2/9/24.
//

import SwiftUI

struct NormalMemoListView: View {
    @Environment(AppState.self) private var appState
    @Environment(MemoManager.self) private var memoManager
    let folder: Folder
    
    var body: some View {
        @Bindable var normalManager = memoManager.normalMemoManager
        List {
            ForEach(folder.momos) { memo in
                NavigationLink(value: memo) {
                    VStack(alignment: .leading, spacing: 14) {
                        Text(memo.title)
                            .foregroundStyle(appState.theme.accent)
                            .bold()
                        Text(memo.content)
                            .foregroundStyle(appState.theme.primary)
                            .lineLimit(3)
                        
                        Text(NTFormatter.shared.string(memo.date, style: .yyyyMMddE))
                            .font(.caption)
                            .foregroundStyle(appState.theme.secondary)
                    }
                    .swipeActions(edge: .trailing) {
                        Button("Delete") {
                            
                        }
                        .tint(.red)
                    }
                }
                .listRowBackground(appState.theme.container)
            }
        }
        .scrollContentBackground(.hidden)
        .listRowSpacing(10)
        .background(appState.theme.background)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(folder.title)
        .onAppear {
            memoManager.normalMemoManager.onAppear(folder)
        }
        .navigationDestination(for: Memo.self) { memo in
            NormalMemoView(memo: memo)
        }
        .navigationDestination(item: $normalManager.editingMemo) { memo in
            NormalMemoView(memo: memo)
        }        
    }
}

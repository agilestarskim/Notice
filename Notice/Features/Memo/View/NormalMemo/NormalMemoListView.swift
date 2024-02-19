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
            ForEach(memoManager.normalMemos) { memo in
                Button {
                    normalManager.openMemo(memo)
                } label: {
                    VStack(alignment: .leading, spacing: 14) {
                        Text(memo.title)
                            .foregroundStyle(appState.theme.accent)
                            .bold()
                        Text(memo.content)
                            .foregroundStyle(appState.theme.primary)
                            .lineLimit(3)
                        
                        HStack {
                            Text(NTFormatter.shared.string(memo.date, style: .yyyyMMddE))
                                .font(.caption)
                                .foregroundStyle(appState.theme.secondary)
                            
                            if memo.pin {
                                Image(systemName: "pin")
                                    .imageScale(.small)
                                    .foregroundStyle(appState.theme.primary)
                            }                            
                        }
                        
                    }
                }
                .listRowBackground(appState.theme.container)
                .swipeActions(edge: .trailing) {
                    Button("Delete") {
                        memoManager.onTapNormalMemoDeleteButton(memo)
                    }
                    .tint(.red)
                }
                .swipeActions(edge: .leading) {
                    Button {
                        memoManager.onTapPinButton(memo)
                    } label: {
                        Label("Pin", systemImage: "pin")
                    }
                    .tint(appState.theme.accent)
                }
            }
        }
        .animation(.default, value: memoManager.normalMemos)
        .scrollContentBackground(.hidden)
        .listRowSpacing(10)
        .background(appState.theme.background)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(folder.title)
        .onAppear {
            memoManager.onAppearNormalMemoListView(at: folder)
        }
        .navigationDestination(item: $normalManager.editingMemo) { memo in
            NormalMemoView(memo: memo)
        }
    }
}

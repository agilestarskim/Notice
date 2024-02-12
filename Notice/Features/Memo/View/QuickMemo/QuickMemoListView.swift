//
//  QuickMemoListView.swift
//  Notice
//
//  Created by 김민성 on 2/9/24.
//

import SwiftUI

struct QuickMemoListView: View {
    @Environment(AppState.self) private var appState
    @Environment(MemoManager.self) private var memoManager    
    
    var body: some View {
        @Bindable var quickManager = memoManager.quickMemoManager
        List(memoManager.quickMemos) { memo in
            Button {
                quickManager.openQuickMemo(memo)
            } label: {
                VStack(alignment: .leading, spacing: 14) {
                    Text(memo.content)
                        .foregroundStyle(appState.theme.primary)
                        .lineLimit(3)
                    
                    Text(NTFormatter.shared.string(memo.date, style: .yyyyMMddE))
                        .font(.caption)
                        .foregroundStyle(appState.theme.secondary)
                }
            }
            .listRowBackground(appState.theme.container)
            .swipeActions(edge: .trailing) {
                Button("Delete") {
                    memoManager.onTapQuickMemoDeleteButton(memo)
                }
                .tint(.red)
            }
        }
        .animation(.default, value: memoManager.quickMemos)
        .listRowSpacing(10)
        .background(appState.theme.background)
        .scrollContentBackground(.hidden)
        .onAppear(perform: memoManager.onAppearQuickMemoListView)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Quick Memo")     
        .navigationDestination(item: $quickManager.editingQuickMemo) { quickMemo in
            QuickMemoView(memo: quickMemo)
        }
    }
}

#Preview {
    QuickMemoListView()
}

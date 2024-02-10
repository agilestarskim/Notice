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
        List(memoManager.quickMemos) { memo in
            NavigationLink(value: memo) {
                VStack(alignment: .leading, spacing: 14) {
                    Text(memo.content)
                        .foregroundStyle(appState.theme.primary)
                        .lineLimit(3)
                    
                    Text(NTFormatter.shared.string(memo.date, style: .yyyyMMddE))
                        .font(.caption)
                        .foregroundStyle(appState.theme.secondary)
                }
                .swipeActions(edge: .trailing) {
                    Button("Delete") {
                        memoManager.onTapQuickMemoDeleteButton(memo)
                    }
                    .tint(.red)
                }                
            }
            .listRowBackground(appState.theme.container)
        }
        .animation(.default, value: memoManager.quickMemos)
        .listRowSpacing(10)
        .background(appState.theme.background)
        .scrollContentBackground(.hidden)
        .onAppear(perform: memoManager.quickMemoManager.onAppear)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Quick Memo")    
        .navigationDestination(for: QuickMemo.self) { memo in
            QuickMemoView(memo: memo)
        }
    }
}

#Preview {
    QuickMemoListView()
}

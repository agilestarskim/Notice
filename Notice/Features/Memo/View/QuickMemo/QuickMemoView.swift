//
//  QuickMemoView.swift
//  Notice
//
//  Created by 김민성 on 2/9/24.
//

import SwiftUI

struct QuickMemoView: View {
    @Environment(AppState.self) private var appState
    @Environment(MemoManager.self) private var memoManager
    @FocusState private var isFocus: Bool
    @Bindable var memo: QuickMemo
    
    var body: some View {
        VStack {
            TextEditor(text: $memo.content)
                .focused($isFocus)
                .textEditorStyle(.plain)
                .background(appState.theme.background)
                .foregroundStyle(appState.theme.primary)
                .padding()
                .toolbar {
                    ToolbarItem(placement: .keyboard) {
                        HStack {
                            Spacer()
                            Button {
                                isFocus = false
                            } label: {
                                Text("Keyboard ▼")
                            }
                            .tint(.primary)
                        }
                    }
                }
        }
        .background(appState.theme.background)
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle("Quick Memo")
        .onAppear(perform: appState.hideTab)
        .onDisappear(perform: appState.showTab)
    }
}

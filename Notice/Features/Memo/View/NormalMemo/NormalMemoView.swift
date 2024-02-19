//
//  NormalMemoView.swift
//  Notice
//
//  Created by 김민성 on 2/10/24.
//

import SwiftUI

struct NormalMemoView: View {
    @Environment(AppState.self) private var appState
    @Environment(MemoManager.self) private var memoManager
    @FocusState private var isFocus: Bool
    @Bindable var memo: Memo
    
    var body: some View {
        VStack {
            TextEditor(text: $memo.title)
                .textEditorStyle(.plain)
                .background(appState.theme.background)
                .foregroundStyle(appState.theme.accent)
                .font(.largeTitle)
                .bold()
                .frame(height: 50)
                .autocorrectionDisabled()
            TextEditor(text: $memo.content)
                .focused($isFocus)
                .textEditorStyle(.plain)
                .background(appState.theme.background)
                .foregroundStyle(appState.theme.primary)
                .autocorrectionDisabled()
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
        .padding()
        .background(appState.theme.background)
        .onAppear { memoManager.onAppearNormalMemoView(memo) }
        .onDisappear { memoManager.onDisappearNormalMemoView(memo) }
    }
}

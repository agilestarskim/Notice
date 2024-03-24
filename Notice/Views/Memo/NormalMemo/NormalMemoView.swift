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
    @Bindable var memo: Memo
    
    @State private var showingTitleEditor: Bool = false
    @State private var title: String = ""
    
    var body: some View {
        VStack {
            Text(memo.title)
                .background(appState.theme.background)
                .foregroundStyle(appState.theme.accent)
                .font(.title.bold())
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .contentShape(.rect)
                .onTapGesture {
                    showingTitleEditor = true
                }
            
            TextEditor(text: $memo.content)
                .scrollDismissesKeyboard(.immediately)
                .textEditorStyle(.plain)
                .lineSpacing(10)
                .background(appState.theme.background)
                .foregroundStyle(appState.theme.primary)
                .autocorrectionDisabled()
                .contentMargins(.horizontal, 20, for: .scrollContent)
        }
        .alert("메모 제목을 입력하세요", isPresented: $showingTitleEditor) {
            TextField("메모 제목을 입력하세요", text: $title)
                .foregroundStyle(.black)
            Button("OK") {
                memo.title = title
            }
            .disabled(title.isEmpty)
            
            Button("Cancel", role: .cancel) { }
        }
        .background(appState.theme.background)
        .onAppear { memoManager.onAppearNormalMemoView(memo) }
        .onDisappear { memoManager.onDisappearNormalMemoView(memo) }
    }
}

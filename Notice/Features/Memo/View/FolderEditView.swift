//
//  MemoFolderEditView.swift
//  Notice
//
//  Created by 김민성 on 2/9/24.
//

import SwiftUI

struct FolderEditView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(AppState.self) private var appState
    @Environment(MemoManager.self) private var memoManager
    var body: some View {
        @Bindable var folderManager = memoManager.folderManager
        FormContainer(
            title: "폴더 만들기",
            theme: appState.theme,
            button: {
                Button("완료") {
                    memoManager.onTapFolderEditDoneButton()                    
                }
                .tint(appState.theme.accent)
            },
            content: {
                Section {
                    TitleTextField
                    NTEmojiPicker(emoji: $folderManager.folderEmoji, selectColor: appState.theme.primary)
                }
                .listRowBackground(appState.theme.container.opacity(0.8))
            }
        )
    }
    
    var TitleTextField: some View {
        @Bindable var folderManager = memoManager.folderManager
        return TextField(
            "title",
            text: $folderManager.folderTitle,
            prompt: Text("제목을 입력하세요 (필수)")
                .foregroundStyle(appState.theme.secondary)
        )
        .autocorrectionDisabled()
    }
}

#Preview {
    FolderEditView()
}

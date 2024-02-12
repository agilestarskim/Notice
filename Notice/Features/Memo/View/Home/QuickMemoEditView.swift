//
//  QuickMemoView.swift
//  Notice
//
//  Created by 김민성 on 2/9/24.
//

import SwiftUI

struct QuickMemoEditView: View {
    @Environment(AppState.self) private var appState
    @Environment(MemoManager.self) private var memoManager
    @FocusState private var isEditing: Bool
    
    var body: some View {
        @Bindable var quickMemo = memoManager.quickMemoManager
        VStack {
            HStack {
                Text("Quick")
                    .font(.title.bold())
                    .foregroundStyle(appState.theme.primary)
                    .padding(.horizontal)
                Spacer()
                
                if isEditing {
                    Button("Keyboard ▾") {                        
                        isEditing = false
                    }
                    .tint(appState.theme.primary)
                    .buttonStyle(.bordered)
                    .transition(.scale)
                }
                
                Button("Save") {                    
                    memoManager.onTapQuickMemoSaveButton()
                    isEditing = false
                }
                .tint(appState.theme.accent)                
                .buttonStyle(.bordered)
            }
            .animation(.bouncy, value: isEditing)
            
            
            TextEditor(text: $quickMemo.quickMemoText)
                .focused($isEditing)
                .textEditorStyle(.plain)
                .foregroundStyle(appState.theme.primary)                
                .padding()
                .frame(height: 130)
                .background(appState.theme.container)
                .clipShape(.rect(cornerRadius: 10), style: FillStyle())
                .autocorrectionDisabled()
        }
        .onChange(of: isEditing) {
            if isEditing {
                appState.hideTab()
            } else {
                appState.showTab()
            }
        }
        .background(appState.theme.background)
    }
}

#Preview {
    QuickMemoEditView()
        .environment(AppState())
}

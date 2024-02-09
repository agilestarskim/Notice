//
//  MemoListView.swift
//  Notice
//
//  Created by 김민성 on 2/9/24.
//

import SwiftUI

struct MemoListView: View {
    let memos: [Memo]
    var body: some View {
        List {
            ForEach(memos) { memo in
                Text(memo.title)
            }
        }
        .scrollContentBackground(.hidden)
    }
}

#Preview {
    MemoListView(memos: [])
}

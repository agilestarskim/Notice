//
//  GoalPendingView.swift
//  Notice
//
//  Created by 김민성 on 1/1/24.
//

import SwiftUI

struct GoalPendingView: View {
    var body: some View {
        VStack {
            ForEach(0..<10, id: \.self) { index in
                PendingCardView()
            }
        }
    }
}

#Preview {
    GoalPendingView()
}

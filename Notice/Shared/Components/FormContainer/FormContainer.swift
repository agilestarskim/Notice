//
//  FormHeader.swift
//  Notice
//
//  Created by 김민성 on 1/21/24.
//

import SwiftUI

struct FormContainer<Button: View, Content: View>: View {
    let title: String
    let theme: Theme
    let button: () -> Button
    let content: () -> Content
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .trailing) {
                Text(title)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(theme.accent)
                    .frame(maxWidth: .infinity)
                button()
            }
            .padding()
            
            content()
        }
        .background(theme.background)
    }
}

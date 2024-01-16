//
//  NTColorPicker.swift
//  Notice
//
//  Created by 김민성 on 1/16/24.
//

import SwiftUI

struct NTColorPicker: View {
    @Binding var color: Color
    private let colors: [Color] = [
        .red,
        .orange,
        .yellow,
        .green,
        .cyan,
        .blue,
        .indigo
    ]
    
    var body: some View {
        HStack {
            ForEach(colors, id: \.self) { color in
                ZStack {
                    Circle()
                        .fill(color)
                        .onTapGesture {
                            self.color = color
                        }
                    if self.color == color {
                        Group {
                            Circle()
                                .fill(.white)
                                .padding(4)
                            Circle()
                                .fill(color)
                                .padding(7)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    NTColorPicker(color: .constant(.blue))
}

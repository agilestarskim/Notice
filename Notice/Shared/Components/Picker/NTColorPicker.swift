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
                        .padding(3)
                        .onTapGesture {
                            self.color = color
                        }
                    if self.color == color {                        
                        Circle()
                            .fill(.white)
                            .padding(5)
                        Circle()
                            .fill(color)
                            .padding(8)
                    }
                }
            }
        }
    }
}

#Preview {
    NTColorPicker(color: .constant(.blue))
}

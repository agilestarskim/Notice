//
//  MSDayView.swift
//  Notice
//
//  Created by 김민성 on 12/10/23.
//

import SwiftUI

struct MSDayView<Content: View>: View {
    let day: Date
    let textColor: Color
    let content: (Date) -> Content
    let isSameMonth: Bool
    let isSameDay: Bool
    let selectedColor: Color
    
    var body: some View {
        VStack {
            if isSameMonth {
                Text("\(Calendar.current.component(.day, from: day))")
                    .fontWeight(.semibold)
                    .foregroundStyle(textColor)
                content(day)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .containerRelativeFrame(.vertical, alignment: .top, { scrollSize, _ in
            scrollSize / 6
        })
        .contentShape(Rectangle())
        .overlay {
            if isSameDay && isSameMonth {
                RoundedRectangle(cornerRadius: 10)
                    .fill(selectedColor.opacity(0.1))
                    .stroke(.dawnSecondary, lineWidth: 0.5, antialiased: true)
                    .transition(.scale)
                    
            }
        }
    }
    
//    static func == (lhs: MSDayView<Content>, rhs: MSDayView<Content>) -> Bool {
//        lhs.day == rhs.day &&
//        lhs.textColor == rhs.textColor &&
//        lhs.isSameDay == rhs.isSameDay &&
//        lhs.isSameMonth == rhs.isSameMonth
//    }
}

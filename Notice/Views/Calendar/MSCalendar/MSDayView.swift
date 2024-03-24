//
//  MSDayView.swift
//  Notice
//
//  Created by 김민성 on 12/10/23.
//

import SwiftUI

struct MSDayView<CellContent: View>: View {
    let day: Date
    let isSameMonth: Bool
    let isSameDay: Bool    
    let textColor: Color
    let selectedColor: Color
    let cellContent: (Date) -> CellContent
    
    var body: some View {
        VStack {
            if isSameMonth {
                Text("\(Calendar.current.component(.day, from: day))")
                    .fontWeight(.semibold)
                    .foregroundStyle(textColor)
                cellContent(day)
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
                    .stroke(selectedColor, lineWidth: 0.5, antialiased: true)
                    .padding(0.5)
                    
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

//
//  MSMonthView.swift
//  Notice
//
//  Created by 김민성 on 12/10/23.
//

import SwiftUI

struct MSInfinteMonthView<CellContent: View>: View {
    @Bindable var handler: CalendarManager.CalendarHandler
    let cellContent: (Date) -> CellContent
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(-100..<100, id: \.self) { index in                    
                    MSDaysView(
                        handler: handler,   
                        pageDate: handler.pageDate(index: index),
                        dates: handler.makeDays(from: index),
                        cellContent: cellContent
                    )
                    .id(index)
                    .containerRelativeFrame(.vertical, alignment: .top)
                }
            }
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.paging)
        .scrollPosition(id: $handler.pageIndex)
        .scrollIndicators(.hidden)
        .onChange(of: handler.pageIndex, handler.onChangePage)
    }
}

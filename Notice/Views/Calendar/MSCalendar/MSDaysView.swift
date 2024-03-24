//
//  MSDaysView.swift
//  Notice
//
//  Created by 김민성 on 12/10/23.
//

import SwiftUI

struct MSDaysView<CellContent: View>: View {
    @Environment(AppState.self) private var appState
    let handler: CalendarManager.CalendarHandler
    let pageDate: Date
    let dates: [Date]
    let cellContent: (Date) -> CellContent
    let columns = Array(repeating: GridItem(spacing: 0, alignment: .top), count: 7)
    
    var body: some View {
        LazyVGrid(columns: self.columns, spacing: 0) {
            ForEach(dates, id: \.self) { day in
                MSDayView(
                    day: day,
                    isSameMonth: handler.isSameMonth(day, pageDate),
                    isSameDay: handler.isSameDay(day, handler.selectedDate),
                    textColor: handler.calendarDayColor(day),
                    selectedColor: appState.theme.secondary,
                    cellContent: cellContent
                )
                .onTapGesture{ handler.onTapCellContent(day) }
            }
        }        
    }
}

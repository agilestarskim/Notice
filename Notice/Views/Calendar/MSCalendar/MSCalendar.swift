//
//  MSCalendar.swift
//  Notice
//
//  Created by 김민성 on 12/10/23.
//

import SwiftUI

struct MSCalendar<CellContent: View>: View {
    @Bindable var handler: CalendarManager.CalendarHandler
    let cellContent: (Date) -> CellContent    
    
    init(
        handler: CalendarManager.CalendarHandler,
        @ViewBuilder cellContent: @escaping (Date) -> CellContent
    ) {        
        self.handler = handler
        self.cellContent = cellContent
    }
    
    var body: some View {
        VStack() {
            MSWeekTitleView()
            MSInfinteMonthView(
                handler: handler,
                cellContent: cellContent
            )
        }
    }
}

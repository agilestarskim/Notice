//
//  MSCalendar.swift
//  Notice
//
//  Created by 김민성 on 12/10/23.
//

import SwiftUI

struct MSCalendar<Content: View>: View {
    @Binding var selectedDate: Date
    @Binding var pageIndex: Int?
    
    let calendar: Calendar
    let content: (Date) -> Content
    
    init(
        selectedDate: Binding<Date>,
        pageIndex: Binding<Int?>,
        calendar: Calendar,
        @ViewBuilder content: @escaping (Date) -> Content
    ) {
        self._selectedDate = selectedDate
        self._pageIndex = pageIndex
        self.calendar = calendar
        self.content = content
    }
    
    var body: some View {
        VStack() {
            MSWeekTitleView()
            MSInfinteMonthView(
                selectedDate: $selectedDate,
                pageIndex: $pageIndex,
                calendar: calendar,
                content: content
            )
        }
    }
}

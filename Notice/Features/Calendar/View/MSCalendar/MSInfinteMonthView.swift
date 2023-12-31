//
//  MSMonthView.swift
//  Notice
//
//  Created by 김민성 on 12/10/23.
//

import SwiftUI

struct MSInfinteMonthView<Content: View>: View {
    @Binding var selectedDate: Date
    @Binding var pageIndex: Int?
    
    let calendar: Calendar
    let content: (Date) -> Content
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(-100..<100, id: \.self) { index in
                    MSDaysView(
                        selectedDate: $selectedDate,
                        pageDate: pageDate(index: index),
                        dates: makeDays(from: index),
                        calendar: calendar,
                        content: content                        
                    )
                    .id(index)
                    .containerRelativeFrame(.vertical, alignment: .top)
                }
            }
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.paging)
        .scrollPosition(id: $pageIndex)
        .scrollIndicators(.hidden)
        .animation(.default, value: pageIndex)
        .onChange(of: pageIndex, onChangePage)        
    }
    
    private func pageDate(index: Int?) -> Date {
        guard let index = index,
              let pageDate = calendar.date(byAdding: .month, value: index, to: .now)?.startOfMonth()
        else {
            return .now
        }
        return pageDate
    }
    
    private func makeDays(from index: Int) -> [Date] {
        guard let monthInterval = calendar.dateInterval(of: .month, for: self.pageDate(index: index)),
              let monthFirstWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.start),
              let monthLastWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.end - 1)
        else { return [] }
       
        let dateInterval = DateInterval(start: monthFirstWeek.start, end: monthLastWeek.end)
        
        return calendar.generateDays(for: dateInterval)
    }
    
    private func onChangePage() {
        if isSameMonth() {
            selectedDate = .now
        } else {
            selectedDate = pageDate(index: pageIndex)
        }
    }
    
    private func isSameMonth() -> Bool {
        calendar.isDate(pageDate(index: pageIndex), equalTo: .now, toGranularity: .month)
    }
}

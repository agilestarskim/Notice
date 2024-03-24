//
//  MSWeekDayView.swift
//  Notice
//
//  Created by 김민성 on 12/10/23.
//

import SwiftUI

struct MSWeekTitleView: View {
    @Environment(AppState.self) private var appState
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(dayOfWeekStrings, id: \.self) { dayOfWeek in
                Text(dayOfWeek)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .font(.subheadline)
                    .foregroundStyle(appState.theme.secondary)
            }
        }
    }
    
    var dayOfWeekStrings: [String] {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        let weekdays = formatter.shortWeekdaySymbols ?? ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
        return weekdays
    }
}

#Preview {
    MSWeekTitleView()
}

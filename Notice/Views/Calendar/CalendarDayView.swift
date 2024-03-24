//
//  CalendarDayView.swift
//  Notice
//
//  Created by 김민성 on 12/23/23.
//

import SwiftData
import SwiftUI

struct CalendarDayView: View {    
    let events: [Event]
    
    var body: some View {
        HStack {
            ForEach(events) { event in
                Circle()
                    .frame(width: 5, height: 5)
                    .foregroundStyle(EventCategory.color(event.category))
            }
        }
    }
}

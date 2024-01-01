//
//  CalendarDetailView.swift
//  Notice
//
//  Created by 김민성 on 11/23/23.
//

import SwiftData
import SwiftUI


struct CalendarDetailView: View {
    @Environment(AppState.self) private var appState
    @EnvironmentObject private var vm: CalendarViewModel
    let events: [Event]
    
    var body: some View {
        List {
            Section {
                if events.isEmpty {
                    Text("이벤트가 없습니다")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                        .font(.title3)
                        .foregroundStyle(appState.theme.primary)
                        .listRowBackground(Color.clear)
                } else{
                    ForEach(events) { event in
                        EventView(event: event)
                    }
                }
            } header: {
                HStack {
                    Text(Format.shared.string(vm.selectedDate, style: .yyyyMMddE))
                    Spacer()
                    Text(vm.calendar.isDateInToday(vm.selectedDate) ? "Today" : "")
                }
                .foregroundStyle(appState.theme.secondary)
                
            }
                        
        }
        .listRowSpacing(10)
        .listStyle(.grouped)
        .scrollContentBackground(.hidden)        
        .safeAreaPadding(.bottom, 70)
    }
}

#Preview {
    CalendarDetailView(events: [])
}

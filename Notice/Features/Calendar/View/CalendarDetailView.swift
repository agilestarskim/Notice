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
                    Text("일정이 없습니다")
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
                    Text(NTFormatter.shared.string(vm.selectedDate, style: .yyyyMMddE))
                    Text(vm.calendar.isDateInToday(vm.selectedDate) ? "Today" : "")
                    Spacer()
                    Button(action: vm.gotoToday) {
                        Image(systemName: "clock.arrow.circlepath")
                    }
                    .tint(appState.theme.container)
                    .buttonStyle(.borderedProminent)
                }
                .foregroundStyle(appState.theme.secondary)
                
            }
                        
        }
        .listRowSpacing(10)
        .listStyle(.grouped)
        .scrollContentBackground(.hidden)          
        .safeAreaPadding(.bottom, appState.bottomSafeAreaPadding)
    }
}

#Preview {
    CalendarDetailView(events: [])
}

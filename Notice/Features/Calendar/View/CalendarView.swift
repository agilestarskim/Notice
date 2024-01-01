//
//  CalendarView.swift
//  Notice
//
//  Created by 김민성 on 11/6/23.
//

import SwiftUI
import SwiftData

struct CalendarView: View {
    @Environment(AppState.self) private var appState
    @EnvironmentObject private var vm: CalendarViewModel
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                VStack(spacing: 0) {
                    MSCalendar(
                        selectedDate: $vm.selectedDate,
                        pageIndex: $vm.pageIndex,
                        calendar: vm.calendar,
                        content: { CalendarDayView(events: vm.dailyEvents(by: $0)) }
                    )
                    .frame(height: geo.size.height * 0.5)                    
                    
                    CalendarDetailView(events: vm.dailyEvents)
                        .frame(height: geo.size.height * 0.5)
                }
                .frame(maxHeight: .infinity)
                .background(appState.theme.background)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.hidden, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(Format.shared.string(vm.pageDate, style: .yyyyMM))
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(appState.theme.accent)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: vm.gotoToday) {
                        Image(systemName: "clock.arrow.circlepath")
                    }
                    .tint(appState.theme.accent)
                    .buttonStyle(.bordered)
                }
            }
        }        
        .sheet(isPresented: $vm.isOpenEditorToCreate) {
            CalendarFormView(defaultStartDate: vm.selectedDate)
        }
        .onAppear {
            appState.onTapPlusButton = vm.onTapPlusButton
        }
        .onChange(of: vm.pageIndex) {
            vm.fetchMontlyEvents()
        }
    }
}

//
//  EventView.swift
//  Notice
//
//  Created by 김민성 on 11/27/23.
//

import SwiftUI

struct EventView: View {
    @Environment(AppState.self) private var appState
    @Environment(CalendarManager.self) private var calendarManager
    let event: Event
    
    var body: some View {
        @Bindable var editor = calendarManager.editManager
        HStack(alignment: .top, spacing: 20) {
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 20) {
                    Text(NTFormatter.shared.string(event.startDate, style: .hmma))
                        .font(.subheadline)
                        .foregroundStyle(appState.theme.primary)
                    
                    Circle()
                        .frame(width: 8, height: 8)
                        .foregroundStyle(EventCategory.color(event.category).opacity(0.8))
                }
                
                Text(event.category)
                    .font(.footnote)
                    .foregroundStyle(appState.theme.secondary)
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text(event.title)
                    .foregroundStyle(appState.theme.primary)
                    .fontWeight(.semibold)
                
                if !event.memo.isEmpty {
                    Text(event.memo)
                        .font(.footnote)
                        .foregroundStyle(appState.theme.secondary)
                }
            }
            
            Spacer()
        }
        .listRowSeparator(.hidden)
        .listRowBackground(appState.theme.container.opacity(0.5))
        .sheet(item: $editor.editingEvent) { _ in
            CalendarFormView()
        }
        .swipeActions(edge: .leading) {
            Button("Edit") {
                calendarManager.onTapEditEventButton(event)
            }
            .tint(appState.theme.accent)
        }
        .swipeActions(edge: .trailing) {
            Button("Delete", role: .destructive) { calendarManager.onTapDeleteEventButton(event) }
        }
    }
}

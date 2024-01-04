//
//  EventView.swift
//  Notice
//
//  Created by 김민성 on 11/27/23.
//

import SwiftUI

struct EventView: View {
    @Environment(AppState.self) private var appState
    @EnvironmentObject private var vm: CalendarViewModel
    let event: Event
    
    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 20) {
                    Text(Format.shared.string(event.startDate, style: .hmma))
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
        .sheet(item: $vm.editingEvent) { _ in
            CalendarFormView()
        }
        .swipeActions(edge: .leading) {
            Button("Edit") {
                vm.onTapEditButton(event)
            }
            .tint(appState.theme.accent)
        }
        .swipeActions(edge: .trailing) {
            Button("Delete", role: .destructive) { vm.delete(event) }                
        }
    }
}

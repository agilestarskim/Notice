//
//  TodoCellView.swift
//  Notice
//
//  Created by 김민성 on 11/13/23.
//

import SwiftUI

struct TodoCellView: View {
    @Environment(AppState.self) private var appState
    @EnvironmentObject private var vm: TodoViewModel
    let todo: Todo
    
    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            Button {
                vm.toggleDone(todo)
            } label: {
                vm.doneButtonImage(todo)
                    .font(.title)
            }
            .buttonStyle(.plain)
            .foregroundStyle(todo.isDone ? appState.theme.accent : appState.theme.secondary)
            
            VStack(alignment: .leading) {
                Text(todo.title)
                    .foregroundStyle(appState.theme.primary)
                    .fontWeight(.semibold)
                
                if !todo.memo.isEmpty {
                    Text(todo.memo)
                        .font(.footnote)
                        .foregroundStyle(appState.theme.secondary)
                }
                
                HStack {
                    Text(Format.shared.day(todo.date) + " " + Format.shared.time(todo.date))
                        .foregroundStyle(appState.theme.secondary)
                        .font(.footnote)
                    
                    if todo.flag {
                        Image(systemName: "flag.fill")
                            .foregroundStyle(appState.theme.accent)
                            .imageScale(.small)
                    }
                }            
            }
        }
        .listRowSeparator(.hidden)
        .listRowBackground(appState.theme.container)
        .swipeActions(edge: .leading) {
            Button("Edit", action: vm.onTapEditButton)
                .tint(appState.theme.accent)
        }
        .sheet(isPresented: $vm.isOpenEditorToEdit) {
            TodoFormView(todo: self.todo)
        }
    }
}

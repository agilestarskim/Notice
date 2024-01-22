//
//  RoutineView.swift
//  Notice
//
//  Created by 김민성 on 1/5/24.
//

import SwiftUI

struct RoutineView: View {
    @Environment(AppState.self) private var appState
    @EnvironmentObject private var manager: RoutineManager
    
    var body: some View {
        List {
            ForEach(manager.routines) { routine in
                RoutineCellView(routine: routine)
            }
        }
        .animation(.default, value: manager.routines)
        .listRowSpacing(10)
        .scrollContentBackground(.hidden)
        .safeAreaPadding(.bottom, 70)
        .sheet(isPresented: $manager.shouldOpenEditor) {
            RoutineFormView()
        }
        .onAppear {
            appState.onTapPlusButton = manager.onTapPlusButton
        }
    }
}

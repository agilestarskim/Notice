//
//  RoutineView.swift
//  Notice
//
//  Created by 김민성 on 1/5/24.
//

import SwiftUI

struct RoutineView: View {
    @Environment(AppState.self) private var appState
    @Environment(RoutineManager.self) private var routineManager
    
    var body: some View {
        @Bindable var editManager = routineManager.editManager
        List {
            ForEach(routineManager.routines) { routine in
                RoutineCellView(routine: routine)
            }
        }
        .animation(.default, value: routineManager.routines)
        .listRowSpacing(10)
        .scrollContentBackground(.hidden)        
        .sheet(isPresented: $editManager.shouldOpenEditor) {
            RoutineFormView()
        }
        .onAppear(perform: routineManager.onAppear)
    }
}

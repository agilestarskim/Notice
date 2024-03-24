//
//  RoutineView.swift
//  Notice
//
//  Created by 김민성 on 1/5/24.
//

import SwiftUI

struct RoutineMainView: View {
    @Environment(AppState.self) private var appState
    @Environment(RoutineManager.self) private var routineManager
    
    var body: some View {
        @Bindable var editManager = routineManager.editManager
        List {
            if routineManager.routines.isEmpty {
                Text("루틴이 없습니다")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
                    .font(.title3)
                    .foregroundStyle(appState.theme.primary)
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
            } else {
                ForEach(routineManager.routines) { routine in
                    RoutineCellView(routine: routine)
                }
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

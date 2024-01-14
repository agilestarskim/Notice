//
//  GoalView.swift
//  Notice
//
//  Created by 김민성 on 1/1/24.
//

import SwiftUI

struct GoalViewList: View {
    @Environment(AppState.self) private var appState
    @EnvironmentObject private var vm: GoalManager
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                FilterPicker
                ScrollView {
                    switch vm.filter {
                    case .underway:
                        GoalOnProgressView()
                    case .success, .failure:
                        GoalSuccessFailureView()
                    }
                }     
                .scrollBounceBehavior(.basedOnSize)
                .scrollIndicators(.hidden)
                .padding(.horizontal, 20)
                .safeAreaPadding(.bottom, 70)
            }
            .background(appState.theme.background)
            .toolbarBackground(.hidden, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("v") {
//                        if vm.viewMode == .collection {
//                            vm.viewMode = .lane
//                        } else {
//                            vm.viewMode = .collection
//                        }                        
                    }
                    .tint(appState.theme.accent)
                    .buttonStyle(.bordered)
                }
            }
        }
        .onAppear {
            appState.onTapPlusButton = vm.onTapPlusButton
        }
//        .sheet(isPresented: $vm.isOpenEditorToCreate) {
//            GoalFormView()
//        }        
    }
    
    var FilterPicker: some View {
        Picker("State", selection: $vm.filter) {
            ForEach(GoalFilter.allCases, id: \.self) { filter in
                Text(filter.rawValue)
                    .tag(filter)
            }
        }
        .pickerStyle(.segmented)
        .colorMultiply(appState.theme.accent)
        .padding(.top)
        .padding(.horizontal)
    }
}

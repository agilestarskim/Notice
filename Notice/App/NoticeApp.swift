//
//  NoticeApp.swift
//  Notice
//
//  Created by 김민성 on 12/20/23.
//

import SwiftUI
import SwiftData

@main
struct NoticeApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Todo.self, Event.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    @State private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            MainView(context: sharedModelContainer.mainContext)
        }
        .modelContainer(sharedModelContainer)
        .environment(appState)        
    }
}

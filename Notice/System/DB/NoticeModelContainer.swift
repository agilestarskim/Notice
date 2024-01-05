//
//  ModelContainer.swift
//  Notice
//
//  Created by 김민성 on 1/5/24.
//

import SwiftData

struct NoticeModelContainer {
    static let shared: ModelContainer = {
        let schema = Schema([
            Todo.self, Event.self, Goal.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
}

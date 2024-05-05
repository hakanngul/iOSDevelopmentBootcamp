//
//  iOSDevelopmentBootcampApp.swift
//  iOSDevelopmentBootcamp
//
//  Created by Hakan Gül on 5.05.2024.
//

import SwiftUI
import SwiftData

@main
struct iOSDevelopmentBootcampApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            HelloSwiftUi()
        }
        //.modelContainer(sharedModelContainer)
    }
}

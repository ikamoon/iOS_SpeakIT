//
//  SpeakPMApp.swift
//  SpeakPM
//
//  Created by mon ika on 2025/10/08.
//

import SwiftUI
import SwiftData

@main
struct SpeakPMApp: App {
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            WordReview.self,
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
            NavigationStack {
                OnboardingFlowView()
//                OnboardingWelcomeView()
//                DeckListView()
            }
        }
        .modelContainer(sharedModelContainer)
    }
}

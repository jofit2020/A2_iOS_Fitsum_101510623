//
//  A2_iOS_Fitsum_101510623App.swift
//  A2_iOS_Fitsum_101510623
//
//  Created by Serbijos on 09/04/26.
//

import SwiftUI
import CoreData

@main
struct A2_iOS_Fitsum_101510623App: App {
    let persistenceController = PersistenceController.shared

    init() {
        let context = persistenceController.container.viewContext
        SampleDataSeeder.seedIfNeeded(context: context)
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

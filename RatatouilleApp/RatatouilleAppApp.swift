//
//  RatatouilleAppApp.swift
//  RatatouilleApp
//
//  Created by User on 2023-11-14.
//

import SwiftUI

@main
struct RatatouilleAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

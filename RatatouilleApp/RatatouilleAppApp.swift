//
//  RatatouilleAppApp.swift
//  RatatouilleApp
//
//  Created by User on 2023-11-14.
//

import SwiftUI

@main struct RatatouilleAppApp: App {
    
    private let coreDataManager = CoreDataManager.shared
    
    // App Storage egenskaper
    
    @AppStorage(AppStorageConstants.appearance) private var isDarkMode = false
    @AppStorage(AppStorageConstants.firstLaunch) private var hasLaunchedBefore = false
    
    init() {
        
        // UISegmentedControl utseendekonfigurasjon
        
        UISegmentedControl.appearance().backgroundColor = .accent.withAlphaComponent(0.15)
        UISegmentedControl.appearance().setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        UISegmentedControl.appearance().selectedSegmentTintColor = .accent
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
    }
    
    var body: some Scene {
        WindowGroup {
            
            // Innledende visningslogikk
            
            if hasLaunchedBefore {
                ContentView()
                    .environment(\.managedObjectContext, coreDataManager.container.viewContext)
                    .onAppear { AppearanceManager.set(isDarkMode ? .dark : .light) }
                    .tint(Color.accent)
            } else {
                IntroView(hasLaunchedBefore: $hasLaunchedBefore)
            }
        }
    }
}

//
//  ContentView.swift
//  RatatouilleApp
//
//  Created by User on 2023-11-14.
//

import SwiftUI
import CoreData

struct ContentView: View {
  
    
    @StateObject private var viewModel = ContentViewModel()
  
    
    var body: some View {
        ZStack {
            launchScreenOrTabView
                .environmentObject(viewModel)
        }
    }
}


private extension ContentView {
    
    
    var launchScreenOrTabView: some View {
        if viewModel.showLaunchScreen {
            return AnyView(LaunchScreenView().onAppear(perform: viewModel.showTabViewAfterDelay))
        } else {
            return AnyView(tabView)
        }
    }
    
    var tabView: some View {
        TabView {
            MyRecipesView().tabItem {
                Label("Mine oppskrifter", systemImage: "list.bullet")
            }
            SearchView().tabItem {
                Label("Søk", systemImage: "magnifyingglass")
            }
            SettingsView().tabItem {
                Label("Innstillinger", systemImage: "gear")
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

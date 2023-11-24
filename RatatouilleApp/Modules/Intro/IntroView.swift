//
//  IntroView.swift
//  RatatouilleApp
//
//  Created by User on 2023-11-23.
//

import Foundation
import SwiftUI

struct IntroView: View {
    
    // Initialization
    
    init(hasLaunchedBefore: Binding<Bool>) {
        _viewModel = StateObject(wrappedValue: IntroViewModel(hasLaunchedBefore: hasLaunchedBefore))
    }
    
    
    @StateObject private var viewModel: IntroViewModel
    
    var body: some View {
        VStack {
            TabView(selection: $viewModel.currentPage) {
                IntroPageView(imageName: "Remy-1",
                              title: "Velkommen til Ratatouille!",
                              description: "Bla gjennom et mangfold av oppskrifter for enhver smak og anledning.")
                    .tag(0)
                IntroPageView(imageName: "Remy-2",
                              title: "Gjør matlaging til en lek",
                              description: "Våre trinn-for-trinn oppskrifter gjør matlaging enklere og morsommere enn noensinne.")
                    .tag(1)
                IntroPageView(imageName: "Remy-3",
                              title: "Lagre dine favoritter",
                              description: "Med Ratatouille er det enkelt å holde orden på dine favorittoppskrifter. Lagre dine mest elskede retter i en personlig favorittliste for rask og enkel tilgang.")
                    .tag(2)
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            .tint(Color.accent)
            
            Button("Start") {
                viewModel.skipIntro()
            }
            .padding()
            .tint(Color.accent)
        }
        .environmentObject(viewModel)
    }
  
  
}

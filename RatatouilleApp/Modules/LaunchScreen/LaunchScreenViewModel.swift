//
//  LaunchScreenViewModel.swift
//  RatatouilleApp
//
//  Created by User on 2023-11-23.
//

import Foundation
import SwiftUI

class LaunchScreenViewModel: ObservableObject {
  
    
    @Published var hatOffset: CGFloat = -500
    @Published var isAnimating = false
    
// Funksjon for animasjon 
  
    func startAnimations() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
                self.isAnimating = true
            }
        }
        
        withAnimation(Animation.linear(duration: 2)) {
            self.hatOffset = -35
        }
    }
}

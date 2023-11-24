//
//  ContentViewModel.swift
//  RatatouilleApp
//
//  Created by User on 2023-11-23.
//

import Foundation
import SwiftUI

class ContentViewModel: ObservableObject {
    
    @Published var showLaunchScreen = true
    
    func showTabViewAfterDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
                self.showLaunchScreen = false
            }
        }
    }
}

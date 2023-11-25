//
//  IntroViewModel.swift
//  RatatouilleApp
//
//  Created by User on 2023-11-23.
//

import Foundation
import SwiftUI

class IntroViewModel: ObservableObject {

    @Published var currentPage = 0
    @Binding var hasLaunchedBefore: Bool
    
    
    init(hasLaunchedBefore: Binding<Bool>) {
        _hasLaunchedBefore = hasLaunchedBefore
    }

    // Hopper over intro hvis brukeren har sett det før.
  
    func skipIntro() {
        hasLaunchedBefore = true
    }
}

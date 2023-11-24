//
//  IntroPageView.swift
//  RatatouilleApp
//
//  Created by User on 2023-11-23.
//

import Foundation
import SwiftUI

struct IntroPageView: View {
    
    // MARK: - Properties
    
    let imageName: String
    let title: String
    let description: String
    
    
    // MARK: - Main View Configuration
    
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 200)
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .padding()
            Text(description)
                .multilineTextAlignment(.center)
                .padding()
        }
    }
}

//
//  LaunchScreenView.swift
//  RatatouilleApp
//
//  Created by User on 2023-11-20.
//

import Foundation
import SwiftUI

struct LaunchScreenView: View {
    
    
    @StateObject private var viewModel = LaunchScreenViewModel()
        
    var body: some View {
        ZStack {
            backgroundColor
            remyImage
            remyHatImage
        }
        .environmentObject(viewModel)
    }
}



private extension LaunchScreenView {
    
    var backgroundColor: some View {
        Color.black.edgesIgnoringSafeArea(.all)
    }
    
    var remyImage: some View {
        Image("Remy-3")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 150, height: 150)
            .offset(x: 0, y: 0)
            .onAppear {
                viewModel.startAnimations()
            }
    }
    
    var remyHatImage: some View {
        Image("hat")
            .resizable()
            .frame(width: 50, height: 50)
            .aspectRatio(contentMode: .fit)
            .offset(x: 12, y: viewModel.hatOffset)
            .onAppear {
                viewModel.startAnimations()
            }
    }
}



struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
    }
}

//
//  AppearanceManager.swift
//  RatatouilleApp
//
//  Created by User on 2023-11-14.
//

import Foundation
import UIKit

enum AppearanceManager {
    
    // Appearance cases
    case light, dark
    
    
    // Fast system Appearance update methods
    
    static func set(_ scheme: AppearanceManager) {
        UIApplication.shared.windows.first?.rootViewController?.overrideUserInterfaceStyle = (scheme == .dark) ? .dark : .light
    }
}

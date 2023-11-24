//
//  FoundationExtensions.swift
//  RatatouilleApp
//
//  Created by User on 2023-11-15.
//

import Foundation

extension Date {
    
    func string() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
}

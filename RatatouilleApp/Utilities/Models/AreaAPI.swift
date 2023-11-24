//
//  AreaAPI.swift
//  RatatouilleApp
//
//  Created by User on 2023-11-16.
//

import Foundation

struct AreaAPI: Codable, Hashable {
    
    let strArea: String
}

struct AreaAPIResponse: Codable {
    
    let meals: [AreaAPI]
}

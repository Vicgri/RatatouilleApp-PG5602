//
//  Category.swift
//  RatatouilleApp
//
//  Created by User on 2023-11-19.
//

import Foundation

struct CategoryAPI: Codable, Hashable {
    
    let strCategory: String
}

struct CategoryAPIResponse: Codable {

    let meals: [CategoryAPI]
}

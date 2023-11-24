//
//  IngredientAPI.swift
//  RatatouilleApp
//
//  Created by User on 2023-11-18.
//

import Foundation

struct IngredientAPI: Codable, Hashable {
    
    // Properties
    
    let idIngredient: String
    let strIngredient: String
    let strDescription: String? 
}

struct IngredientsAPIResponse: Codable {

    
    let meals: [IngredientAPI]
}

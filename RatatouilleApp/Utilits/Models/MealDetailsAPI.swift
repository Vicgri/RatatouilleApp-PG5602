//
//  MealDetails.swift
//  RatatouilleApp
//
//  Created by User on 2023-11-15.
//

import Foundation

struct MealDetailsAPI: Codable, Identifiable {
    
    
    var id: String { strMeal }
    
    // Properties
    
    let strMeal: String
    let strCategory: String?
    let strArea: String?
    let strInstructions: String?
    let strMealThumb: String
    let strTags: String? 
}

struct MealDetailsAPIResponse: Codable {
    
    
    let meals: [MealDetailsAPI]
}

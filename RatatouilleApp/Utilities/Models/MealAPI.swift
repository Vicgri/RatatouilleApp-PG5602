//
//  Meal.swift
//  RatatouilleApp
//
//  Created by User on 2023-11-14.
//

import Foundation

struct MealAPI: Codable, Identifiable {
  
  // Used to conform to the 'Identifiable' protocol which requires an 'id' property
    var id: String { idMeal }
    
    var idMeal: String
    var strMeal: String
    var strCategory: String?
    var strMealThumb: String
}

struct MealAPIResponse: Codable {
    
    // Properties
    
    var meals: [MealAPI]
}

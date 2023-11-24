//
//  Meal.swift
//  RatatouilleApp
//
//  Created by User on 2023-11-14.
//

import Foundation

struct MealAPI: Codable, Identifiable {
    
    // Identifiable
    
    var id: String { idMeal }
    
    // Properties
    
    var idMeal: String
    var strMeal: String
    var strCategory: String?
    var strMealThumb: String
}

struct MealAPIResponse: Codable {
    
    // Properties
    
    var meals: [MealAPI]
}

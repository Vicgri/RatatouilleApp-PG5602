//
//  Meal.swift
//  RatatouilleApp
//
//  Created by User on 2023-11-14.
//

import Foundation

struct MealAPI: Codable, Identifiable {
  
  // Brukt for å følge 'Identifiable'-protokollen som krever en 'id'-egenskap
    var id: String { idMeal }
    
    var idMeal: String
    var strMeal: String
    var strCategory: String?
    var strMealThumb: String
}

struct MealAPIResponse: Codable {
    
    var meals: [MealAPI]
}

//
//  MealDetails.swift
//  RatatouilleApp
//
//  Created by User on 2023-11-15.
//

import Foundation

struct MealDetailsAPI: Codable, Identifiable {
    
  // Brukt for å følge 'Identifiable'-protokollen som krever en 'id'-egenskap
    var id: String { strMeal }

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

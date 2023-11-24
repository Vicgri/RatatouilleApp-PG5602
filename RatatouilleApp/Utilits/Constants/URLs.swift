//
//  URLs.swift
//  RatatouilleApp
//
//  Created by User on 2023-11-15.
//

import Foundation

public enum URLs {
    
    enum Filter {
        static let mealNameSearchURL         = "https://www.themealdb.com/api/json/v1/1/search.php?s="
        static let mealIngredientSearchURL   = "https://www.themealdb.com/api/json/v1/1/filter.php?i="
        static let mealIdSearchURL           = "https://www.themealdb.com/api/json/v1/1/lookup.php?i="
        static let mealAreaSearchURL         = "https://www.themealdb.com/api/json/v1/1/filter.php?a="
        static let mealCategorySearchURL     = "https://www.themealdb.com/api/json/v1/1/filter.php?c="
    }
    
    
    enum List {
        static let listAllMealCategoriesURL      = "https://www.themealdb.com/api/json/v1/1/list.php?c=list"
        static let listAllMealIngredientsURL     = "https://www.themealdb.com/api/json/v1/1/list.php?i=list"
        static let listAllMealAreasURL           = "https://www.themealdb.com/api/json/v1/1/list.php?a=list"
    }
}

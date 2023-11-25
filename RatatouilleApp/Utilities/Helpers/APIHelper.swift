//
//  APIManager.swift
//  RatatouilleApp
//
//  Created by User on 2023-11-14.
//

import Foundation

final class APIHelper {
    
    // Singleton og egenskaper
    
    static let shared = APIHelper()
    private let session = URLSession.shared
    
    // API forespørsel
    
    func loadMeals(selectedSearchOption: FilterSearchType, searchText: String, completion: @escaping (([MealAPI]) -> Void)) {
        fetch(selectURL(for: selectedSearchOption, searchText: searchText), decodingType: MealAPIResponse.self) { decodedData in
            completion(decodedData?.meals ?? [])
        }
    }
    
    func fetchAreas(completion: @escaping ([AreaAPI]) -> ()) {
        fetch(URLs.List.listAllMealAreasURL, decodingType: AreaAPIResponse.self) { decodedData in
            completion(decodedData?.meals ?? [])
        }
    }
    
    func fetchIngredients(completion: @escaping ([IngredientAPI]) -> ()) {
        fetch(URLs.List.listAllMealIngredientsURL, decodingType: IngredientsAPIResponse.self) { decodedData in
            completion(decodedData?.meals ?? [])
        }
    }
    
    func fetchCategories(completion: @escaping ([CategoryAPI]) -> ()) {
        fetch(URLs.List.listAllMealCategoriesURL, decodingType: CategoryAPIResponse.self) { decodedData in
            completion(decodedData?.meals ?? [])
        }
    }
    
    func fetchMealDetails(mealId: String, completion: @escaping (MealDetailsAPI?) -> ()) {
        fetch("\(URLs.Filter.mealIdSearchURL)\(mealId)", decodingType: MealDetailsAPIResponse.self) { decodedData in
            completion(decodedData?.meals.first)
        }
    }
}


private extension APIHelper {
    
    //  Hjelper metoder
    
    func fetch<T: Decodable>( _ urlString: String, decodingType: T.Type, completion: @escaping (T?) -> ()) {
        guard let url = URL(string: urlString) else { return }
        session.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            let decodedData = try? JSONDecoder().decode(decodingType, from: data)
            DispatchQueue.main.async {
                completion(decodedData)
            }
        }.resume()
    }
    
    func selectURL(for option: FilterSearchType, searchText: String) -> String {
        let lowercasedSearchText = searchText.lowercased()
        switch option {
        case .meal:       return "\(URLs.Filter.mealNameSearchURL)\(lowercasedSearchText)"
        case .category:   return "\(URLs.Filter.mealCategorySearchURL)\(lowercasedSearchText)"
        case .ingredient: return "\(URLs.Filter.mealIngredientSearchURL)\(lowercasedSearchText)"
        case .area:       return "\(URLs.Filter.mealAreaSearchURL)\(lowercasedSearchText)"
        }
    }
}

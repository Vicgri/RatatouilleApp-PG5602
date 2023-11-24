//
//  Persistence.swift
//  RatatouilleApp
//
//  Created by User on 2023-11-14.
//

import Foundation
import CoreData

final class CoreDataManager {
    
    // Main CoreData Container
    
    let container: NSPersistentContainer = NSPersistentContainer(name: "RatatouilleApp")
    
    
  // Defines a static instance of CoreDataManager, creating a singleton pattern.
  // This ensures that there's only one instance of CoreDataManager throughout the application,
  // which can be accessed globally using CoreDataManager.shared.
    
    static let shared = CoreDataManager()
    
    
    // Initialization
    
    init() {
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    // Saves changes in the specified Core Data context and handles any errors that may occur during saving
    
    func save(viewContext: NSManagedObjectContext) {
        do {
            try viewContext.save()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}


extension CoreDataManager {
    
    // Meal Operations
    
    func addReciepe(mealDetails: MealDetailsAPI?, viewContext: NSManagedObjectContext) {
        guard let mealDetails = mealDetails else { return }
        let reciept = Meal(context: viewContext)
        reciept.id = UUID()
        reciept.category = mealDetails.strCategory
        reciept.iconURL = mealDetails.strMealThumb
        reciept.instruction = mealDetails.strInstructions
        reciept.isArchived = false
        reciept.isFavourite = false
        reciept.name = mealDetails.strMeal
        reciept.tags = mealDetails.strTags
        save(viewContext: viewContext)
    }
    
    func editReciepe(reciept: Meal, category: String, instruction: String, name: String, tags: String, viewContext: NSManagedObjectContext) {
        reciept.category = category
        reciept.instruction = instruction
        reciept.name = name
        reciept.tags = tags
        save(viewContext: viewContext)
    }
}


extension CoreDataManager {
    
    // Ingredient Operations
    
    func addIngredient(ingredientAPI: IngredientAPI?, viewContext: NSManagedObjectContext) {
        let ingredient = Ingredient(context: viewContext)
        ingredient.name = ingredientAPI?.strIngredient
        ingredient.desc = ingredientAPI?.strDescription
        ingredient.isArchieved = false
        ingredient.dateArchived = nil
        ingredient.id = UUID()
        save(viewContext: viewContext)
    }
}


extension CoreDataManager {
    
    // Category Operations
    
    func addCategory(categoryAPI: CategoryAPI?, viewContext: NSManagedObjectContext) {
        let recieptCategory = Category(context: viewContext)
        recieptCategory.name = categoryAPI?.strCategory
        recieptCategory.isArchieved = false
        recieptCategory.dateArchived = nil
        recieptCategory.id = UUID()
        save(viewContext: viewContext)
    }
}


extension CoreDataManager {
    
    // Area Operations
    
    func addArea(areaAPI: AreaAPI?, iconURL: String, viewContext: NSManagedObjectContext) {
        let area = Area(context: viewContext)
        area.name = areaAPI?.strArea
        area.iconURL = iconURL
        area.isArchieved = false
        area.dateArchived = nil
        area.id = UUID()
        save(viewContext: viewContext)
    }
}

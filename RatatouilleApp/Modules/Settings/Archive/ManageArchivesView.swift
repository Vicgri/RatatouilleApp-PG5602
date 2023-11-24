//
//  ManageArchivesView.swift
//  RatatouilleApp
//
//  Created by User on 2023-11-15.
//

import SwiftUI
import CoreData

struct ManageArchivesView: View {

    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [
            SortDescriptor(\.name, order: .reverse)
        ]
    ) private var savedRecipes: FetchedResults<Meal>
    @FetchRequest(
        sortDescriptors: [
            SortDescriptor(\.name, order: .reverse)
        ]
    ) private var savedAreas: FetchedResults<Area>
    @FetchRequest(
        sortDescriptors: [
            SortDescriptor(\.name, order: .reverse)
        ]
    ) private var savedIngredients: FetchedResults<Ingredient>
    @FetchRequest(
        sortDescriptors: [
            SortDescriptor(\.name, order: .reverse)
        ]
    ) private var savedCategories: FetchedResults<Category>

    
    var body: some View {
        List {
            archievedIngredientsSection
            archievedCategoriesSection
            archievedRecipesSection
            archievedAreasSection
                .navigationTitle("Akriv")
        }
    }
}



private extension ManageArchivesView {

    
    var archievedIngredientsSection: some View {
        Section(header: Text("Ingredienser")) {
            ForEach(savedIngredients) { savedIngredient in
                if savedIngredient.isArchieved {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(savedIngredient.name ?? "Ukjent navn")
                                .fontWeight(.semibold)
                            Text("Arkivert: \((savedIngredient.dateArchived?.string())!)")
                        }
                    }
                    .swipeActions {
                        
                        Button {
                            delete(savedIngredient)
                        } label: {
                            Label("Slett", systemImage: "trash")
                        }
                        .tint(.red)
                        
                        Button {
                            removeFromArchive(savedIngredient)
                        } label: {
                            Label("", systemImage: "tray.and.arrow.up.fill")
                        }
                    }
                }
            }
        }
    }
    var archievedCategoriesSection: some View {
        Section(header: Text("Kategorier")) {
            ForEach(savedCategories) { category in
                if category.isArchieved {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(category.name ?? "Ukjent navn")
                                .fontWeight(.semibold)
                            Text("Arkivert: \((category.dateArchived?.string())!)")
                        }
                    }
                    .swipeActions {
                        
                        Button {
                            delete(category)
                        } label: {
                            Label("Slett", systemImage: "trash")
                        }
                        .tint(.red)
                        
                        Button {
                            removeFromArchive(category)
                        } label: {
                            Label("", systemImage: "tray.and.arrow.up.fill")
                        }
                    }
                }
            }
        }
    }
    var archievedRecipesSection: some View {
        Section(header: Text("Matoppskrifter")) {
            ForEach(savedRecipes) { savedRecipe in
                if savedRecipe.isArchived {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(savedRecipe.name ?? "Ukjent navn")
                                .fontWeight(.semibold)
                            Text("Arkivert: \((savedRecipe.dateArchived?.string())!)")
                        }
                    }
                    .swipeActions {
                        
                        Button {
                            delete(savedRecipe)
                        } label: {
                            Label("Slett", systemImage: "trash")
                        }
                        .tint(.red)
                        
                        Button {
                            removeFromArchive(savedRecipe)
                        } label: {
                            Label("", systemImage: "tray.and.arrow.up.fill")
                        }
                    }
                }
            }
        }
    }
    var archievedAreasSection: some View {
        Section(header: Text("Landomrader")) {
            ForEach(savedAreas) { savedArea in
                if savedArea.isArchieved {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(savedArea.name ?? "Ukjent navn")
                                .fontWeight(.semibold)
                            Text("Arkivert: \((savedArea.dateArchived?.string())!)")
                        }
                    }
                    .swipeActions {
                        
                        Button {
                            delete(savedArea)
                        } label: {
                            Label("Slett", systemImage: "trash")
                        }
                        .tint(.red)
                        
                        Button {
                            removeFromArchive(savedArea)
                        } label: {
                            Label("", systemImage: "tray.and.arrow.up.fill")
                        }
                    }
                }
            }
        }
    }
}



private extension ManageArchivesView {
    
  // Functions for managing the archive
  
    func removeFromArchive(_ recipe: Meal) {
        withAnimation {
            recipe.isArchived.toggle()
            recipe.dateArchived = nil
            CoreDataManager.shared.save(viewContext: viewContext)
        }
    }
    
    func removeFromArchive(_ area: Area) {
        withAnimation {
            area.isArchieved.toggle()
            area.dateArchived = nil
            CoreDataManager.shared.save(viewContext: viewContext)
        }
    }
    
    func removeFromArchive(_ ingredient: Ingredient) {
        withAnimation {
            ingredient.isArchieved.toggle()
            ingredient.dateArchived = nil
            CoreDataManager.shared.save(viewContext: viewContext)
        }
    }
    
    func removeFromArchive(_ category: Category) {
        withAnimation {
            category.isArchieved.toggle()
            category.dateArchived = nil
            CoreDataManager.shared.save(viewContext: viewContext)
        }
    }
    
    func delete(_ object: NSManagedObject) {
        withAnimation {
            viewContext.delete(object)
            CoreDataManager.shared.save(viewContext: viewContext)
        }
    }
}



struct ManageArchivesView_Previews: PreviewProvider {
    static var previews: some View {
        ManageArchivesView()
    }
}

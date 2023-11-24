//
//  MyRecipesView.swift
//  RatatouilleApp
//
//  Created by User on 2023-11-14.
//

import Foundation
import SwiftUI
import CoreData

struct MyRecipesView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [
            SortDescriptor(\.name, order: .reverse)
        ]
    ) private var meals: FetchedResults<Meal>

    
    var body: some View {
        NavigationView {
            if meals.filter({ meal in
                !meal.isArchived
            }).count == 0 {
                emptyMealsView
            } else {
                List {
                    ForEach(meals) { meal in
                        if !meal.isArchived {
                            NavigationLink(destination: EditRecipeView(recipe: meal)) {
                                HStack {
                                    rowPreviewImage(meal)
                                    rowPreviewContent(meal)
                                    
                                    Spacer()
                                    
                                    if meal.isFavourite {
                                        favouriteIcon
                                    }
                                }
                            }
                            .swipeActions {
                                favouriteButton(meal)
                                archiveRecipeButton(meal)
                            }
                        }
                    }
                    .onDelete(perform: deleteRecipe)
                }
                .navigationBarTitle("Tilbake", displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        navigationBarIcon
                    }
                }
            }
        }
    }
}


private extension MyRecipesView {
    
    // MARK: - Views
    
    var emptyMealsView: some View {
        VStack(alignment: .center, content: {
            Image(systemName: "square.stack.3d.up.slash")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 70, height: 70)
                .foregroundColor(.secondary)
                .padding()
            
            Text("Ingen matoppskrifter")
                .font(.headline)
                .fontWeight(.bold)
        })
        .toolbar {
            ToolbarItem(placement: .principal) {
                Image("MyReciepesIcon")
                    .resizable()
                    .frame(width: 100, height: 50)
                    .padding()
            }
        }
    }
    func rowPreviewImage(_ meal: Meal) -> some View {
        AsyncImage(url: URL(string: meal.iconURL!)) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 42, height: 42)
                    .cornerRadius(21)
            case .failure:
                Image(systemName: "photo.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 42, height: 42)
            @unknown default:
                EmptyView()
            }
        }
        .padding(.trailing, 5)
    }
    func rowPreviewContent(_ meal: Meal) -> some View {
        VStack(alignment: .leading) {
            Text(meal.name ?? "Ukjent navn")
                .fontWeight(.semibold)
            Text(meal.category ?? "Gå til detalj for å se kategori.")
        }
    }
    var favouriteIcon: some View {
        Image(systemName: "star.fill")
            .foregroundColor(.yellow)
    }
    func favouriteButton(_ meal: Meal) -> some View {
        Button {
            markAsFavorite(meal)
        } label: {
            Label("Favoritt", systemImage: "star.fill")
        }
        .tint(.yellow)
    }
    func archiveRecipeButton(_ meal: Meal) -> some View {
        Button {
            archiveRecipe(meal)
        } label: {
            Label("Arkiv", systemImage: "archivebox.fill")
        }
        .tint(.blue)
    }
    var navigationBarIcon: some View {
        Image("MyReciepesIcon")
            .resizable()
            .frame(width: 100, height: 50)
            .padding()
    }
}


private extension MyRecipesView {
    
    // MARK: - Main Logic
    
    func markAsFavorite(_ recipe: Meal) {
        withAnimation {
            recipe.isFavourite.toggle()
            CoreDataManager.shared.save(viewContext: viewContext)
        }
    }

    func archiveRecipe(_ recipe: Meal) {
        withAnimation {
            recipe.isArchived.toggle()
            recipe.dateArchived = Date()
            CoreDataManager.shared.save(viewContext: viewContext)
        }
    }

    func deleteRecipe(offsets: IndexSet) {
        withAnimation {
            offsets.map { meals[$0] }.forEach(viewContext.delete)
            CoreDataManager.shared.save(viewContext: viewContext)
        }
    }
}



struct MyRecipesView_Previews: PreviewProvider {
    static var previews: some View {
        MyRecipesView()
    }
}

//
//  SearchIngredientsView.swift
//  RatatouilleApp
//
//  Created by User on 2023-11-18.
//

import SwiftUI

struct SearchIngredientsView: View {
    
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    @State private var searchText = ""
    @State private var ingredients: [IngredientAPI] = []

    
    var body: some View {
        VStack {
            List {
                Section(header: Text("Søk etter ingredienser")) {
                    ForEach(ingredients, id: \.self) { ingredient in
                        HStack {
                            ZStack {
                                Circle()
                                    .fill(LinearGradient(gradient: Gradient(colors: [Color.accent, Color.black]), startPoint: .top, endPoint: .bottom))
                                    .frame(width: 50, height: 50)
                                    .overlay(
                                        Text(String(ingredient.strIngredient.prefix(1)))
                                            .foregroundColor(.white)
                                            .font(.headline)
                                            .fontWeight(.regular)
                                    )
                            }
                            .padding(.trailing, 10)
                            
                            Text(ingredient.strIngredient) 
                        }
                        .swipeActions {
                            Button {
                                saveIngredient(ingredient)
                            } label: {
                                Label("Lagre", systemImage: "square.and.arrow.down")
                            }
                            .tint(.blue)
                        }
                    }
                }
            }
            .onAppear {
                fetchIngredients()
            }
        }
        .navigationTitle("Søk")
    }
}


private extension SearchIngredientsView {
    
    func saveIngredient(_ ingredient: IngredientAPI) {
        CoreDataManager.shared.addIngredient(ingredientAPI: ingredient, viewContext: viewContext)
        presentationMode.wrappedValue.dismiss()
    }
    func fetchIngredients() {
        APIHelper.shared.fetchIngredients { ingredients in
            self.ingredients = ingredients
        }
    }
}


struct SearchIngredientsView_Previews: PreviewProvider {
    static var previews: some View {
        SearchIngredientsView()
    }
}

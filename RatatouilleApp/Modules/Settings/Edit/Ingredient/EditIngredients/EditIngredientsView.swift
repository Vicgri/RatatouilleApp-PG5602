//
//  EditIngredientsView.swift
//  RatatouilleApp
//
//  Created by User on 2023-11-18.
//

import SwiftUI

struct EditIngredientsView: View {

    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Ingredient.entity(), sortDescriptors: []) private var ingredients: FetchedResults<Ingredient>
    
    @State private var isSearchSheetPresented = false

    
    var body: some View {
        List {
            ForEach(ingredients, id: \.id) { ingredient in
                if !ingredient.isArchieved {
                    NavigationLink(destination: EditIngredientView(ingredient: ingredient)) {
                        HStack {
                            ZStack {
                                Circle()
                                    .fill(LinearGradient(gradient: Gradient(colors: [Color.accent, Color.black]), 
                                                         startPoint: .top,
                                                         endPoint: .bottom))
                                    .frame(width: 50, height: 50)
                                    .overlay(
                                        Text(String((ingredient.name?.prefix(1))!))
                                            .foregroundColor(.white)
                                            .font(.headline)
                                            .fontWeight(.regular)
                                    )
                            }
                            .padding(.trailing, 10)
                            
                            Text(ingredient.name!)
                        }
                    }
                    .swipeActions {
                        Button {
                            archieveIngredient(ingredient)
                        } label: {
                            Label("Arkiver", systemImage: "archivebox.fill")
                        }
                        .tint(.blue)
                    }
                }
            }
        }
        .navigationTitle("Ingredienser")
        .navigationBarItems(trailing: NavigationLink(destination: SearchIngredientsView(), label: { Image(systemName: "plus") }))
    }
}


private extension EditIngredientsView {
    
    func archieveIngredient(_ ingredient: Ingredient) {
        withAnimation {
            ingredient.isArchieved = true
            ingredient.dateArchived = Date()
            CoreDataManager.shared.save(viewContext: viewContext)
        }
    }
}


struct EditIngredientsView_Previews: PreviewProvider {
    static var previews: some View {
        EditIngredientsView()
    }
}

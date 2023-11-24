//
//  EditRecipeView.swift
//  RatatouilleApp
//
//  Created by User on 2023-11-15.
//

import Foundation
import SwiftUI
import CoreData

struct EditRecipeView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var recipe: Meal
    
    @State private var editedCategory = ""
    @State private var editedInstruction = ""
    @State private var editedName = ""
    @State private var editedTags = ""
    
    
    var body: some View {
        Form {
            imageSection
            detailsSection
        }
        .onAppear {
            editedCategory = recipe.category ?? ""
            editedInstruction = recipe.instruction ?? ""
            editedName = recipe.name ?? ""
            editedTags = recipe.tags ?? ""
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                saveButton
            }
        }
        .navigationTitle("Rediger oppskrift")
    }
}


private extension EditRecipeView {
    

    var imageSection: some View {
        Section(header: Text("")) {
            HStack {
                Spacer()
                AsyncImage(url: URL(string: recipe.iconURL!)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 180, height: 180)
                            .cornerRadius(95)
                    case .failure:
                        Image(systemName: "photo.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 180, height: 180)
                    @unknown default:
                        EmptyView()
                    }
                }
                Spacer()
            }
            .listRowBackground(Color(.systemGroupedBackground))
        }
    }
    
    var detailsSection: some View {
        Section(header: Text("Oppdater oppskrift")) {
            TextField("Kategori", text: $editedCategory)
            TextEditor(text: $editedInstruction)
                .frame(height: 100)
            TextField("Navn", text: $editedName)
            TextField("Tagger", text: $editedTags)
        }
    }
    
    var saveButton: some View {
        Button("Lagre") {
            save()
        }
    }
}


private extension EditRecipeView {
    
    // Main Logic
    
    func save() {
        CoreDataManager.shared.editReciepe(
            reciept: recipe,
            category: editedCategory,
            instruction: editedInstruction,
            name: editedName,
            tags: editedTags,
            viewContext: viewContext
        )
        presentationMode.wrappedValue.dismiss()
    }
}

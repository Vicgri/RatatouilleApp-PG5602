//
//  EditIngredientView.swift
//  RatatouilleApp
//
//  Created by User on 2023-11-23.
//

import Foundation
import SwiftUI

struct EditIngredientView: View {
    
    // MARK: - Properties
    
    @ObservedObject var ingredient: Ingredient
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var editedName = ""
    @State private var editedDesc = ""
    
    
    // MARK: - Main View Configuration
    
    var body: some View {
        Form {
            Section {
                HStack {
                    Spacer()
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
                    Spacer()
                }
                .listRowBackground(Color(.systemGroupedBackground))
            }
            Section {
                TextField("Edit Category Name", text: $editedName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                TextEditor(text: $editedDesc)
                    .padding()
            }
            .onAppear {
                setInitialName()
            }
        }
        .navigationBarItems(trailing: Button("Save") {
            saveChanges()
        })
        .navigationTitle("Edit Category")
    }
}


private extension EditIngredientView {
    
    // MARK: - Main Logic
    
    func setInitialName() {
        editedName = ingredient.name ?? ""
        editedDesc = ingredient.desc ?? ""
    }
    
    func saveChanges() {
        ingredient.name = editedName
        ingredient.desc = editedDesc
        try? viewContext.save()
    }
}

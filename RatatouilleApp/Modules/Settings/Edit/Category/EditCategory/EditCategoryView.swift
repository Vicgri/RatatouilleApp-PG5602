//
//  EditCategoryView.swift
//  RatatouilleApp
//
//  Created by User on 2023-11-23.
//

import Foundation
import SwiftUI

struct EditCategoryView: View {
    
    // MARK: - Properties
    
    @ObservedObject var category: Category
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var editedName = ""
    
    
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
                                Text(String((category.name?.prefix(1))!))
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
                TextField("Endre kategori navn", text: $editedName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .onAppear {
                        setInitialName()
                    }
            }
        }
        .navigationBarItems(trailing: Button("Lagre") {
            saveChanges()
        })
        .navigationTitle("Rediger kategori")
    }
}


private extension EditCategoryView {
    
    // MARK: - Main Logic
    
    func setInitialName() {
        editedName = category.name ?? ""
    }
    
    func saveChanges() {
        category.name = editedName
        try? viewContext.save()
    }
}

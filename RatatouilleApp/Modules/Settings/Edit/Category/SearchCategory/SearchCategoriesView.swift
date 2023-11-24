//
//  SearchCategoriesView.swift
//  RatatouilleApp
//
//  Created by User on 2023-11-19.
//

import Foundation
import SwiftUI

struct SearchCategoriesView: View {
    
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    @State private var searchText = ""
    @State private var categories: [CategoryAPI] = []
    

    
    var body: some View {
        VStack {
            List {
                Section(header: Text("Søk kategorier")) {
                    ForEach(categories, id: \.self) { category in
                        HStack {
                            ZStack {
                                Circle()
                                    .fill(LinearGradient(gradient: Gradient(colors: [Color.accent, Color.black]), 
                                                         startPoint: .top,
                                                         endPoint: .bottom))
                                    .frame(width: 50, height: 50)
                                    .overlay(
                                        Text(String(category.strCategory.prefix(1)))
                                            .foregroundColor(.white)
                                            .font(.headline)
                                            .fontWeight(.regular)
                                    )
                            }
                            .padding(.trailing, 10)
                            
                            Text(category.strCategory)
                        }
                        .swipeActions {
                            Button {
                                saveCategory(category)
                            } label: {
                                Label("Lagre", systemImage: "square.and.arrow.down")
                            }
                            .tint(.blue)
                        }
                    }
                }
            }
            .onAppear {
                fetchCategories()
            }
        }
        .navigationTitle("Søk") 
    }
}


private extension SearchCategoriesView {

    func saveCategory(_ category: CategoryAPI) {
        CoreDataManager.shared.addCategory(categoryAPI: category, viewContext: viewContext)
        presentationMode.wrappedValue.dismiss()
    }
    
    func fetchCategories() {
        APIHelper.shared.fetchCategories { categories in
            self.categories = categories
        }
    }
}


struct SearchCategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        SearchCategoriesView()
    }
}

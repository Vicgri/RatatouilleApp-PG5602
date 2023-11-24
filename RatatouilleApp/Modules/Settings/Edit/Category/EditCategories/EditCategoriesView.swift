//
//  EditCategoriesView.swift
//  RatatouilleApp
//
//  Created by User on 2023-11-19.
//

import Foundation
import SwiftUI

struct EditCategoriesView: View {
    
    // MARK: - Properties
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: Category.entity(), sortDescriptors: []) private var categories: FetchedResults<Category>
    
    @State private var isSearchSheetPresented = false
    
    
    // MARK: - Main View Configuration
    
    var body: some View {
        List {
            ForEach(categories, id: \.id) { category in
                if !category.isArchieved {
                    NavigationLink(destination: EditCategoryView(category: category)) {
                        HStack {
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
                            .padding(.trailing, 10)
                            Text(category.name!)
                        }
                    }
                    .swipeActions {
                        Button {
                            archive(category)
                        } label: {
                            Label("Archive", systemImage: "archivebox.fill")
                        }
                        .tint(.blue)
                    }
                }
            }
        }
        .navigationTitle("Kategorier")
        .navigationBarItems(trailing: NavigationLink(destination: SearchCategoriesView(), label: { Image(systemName: "plus") }))
    }
}


private extension EditCategoriesView {
    
    // MARK: - Main Logic
    
    func archive(_ category: Category) {
        withAnimation {
            category.isArchieved = true
            category.dateArchived = Date()
        }
    }
}


struct EditCategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        EditCategoriesView()
    }
}

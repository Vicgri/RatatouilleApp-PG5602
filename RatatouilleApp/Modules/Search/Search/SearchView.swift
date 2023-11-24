//
//  SearchView.swift
//  RatatouilleApp
//
//  Created by User on 2023-11-14.
//

import Foundation
import SwiftUI

struct SearchView: View {
 
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var selectedSearchOption: SearchType = .meal
    @State private var searchText = ""
    @State private var isPresentingSearchSheet = false
    @State private var searchResults: [MealAPI] = []

    
    var body: some View {
        NavigationView {
            VStack {
                searchPicker
                searchList
                Spacer()
            }
            .background(Color(.systemGroupedBackground))
            .navigationBarTitle("Søk")
            .navigationBarItems(trailing:
                Button(action: {
                    isPresentingSearchSheet = true
                }) {
                    Image(systemName: "magnifyingglass")
                }
            )
            .sheet(isPresented: $isPresentingSearchSheet) {
                SearchSheetView(searchOption: selectedSearchOption.rawValue, searchText: $searchText, isPresented: $isPresentingSearchSheet) {
                    loadMeals()
                }
                .presentationDetents([.height(330)])
                .presentationDragIndicator(.visible)
            }
        }
    }
}


private extension SearchView {
    
    var searchPicker: some View {
        VStack {
            Picker(selection: $selectedSearchOption, label: Text("Search Options")) {
                Image(systemName: "square.filled.on.square").tag(SearchType.category)
                Image(systemName: "globe").tag(SearchType.area)
                Image(systemName: "carrot").tag(SearchType.ingredient)
                Image(systemName: "fork.knife.circle.fill").tag(SearchType.meal)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding([.trailing, .leading], 16)
        }
    }
    
    var searchList: some View {
        List(searchResults) { meal in
            NavigationLink(destination: DetailReciepeView(mealId: meal.id)) {
                HStack {
                    rowPreviewImage(meal)
                    rowPreviewContent(meal)
                }
            }
            .swipeActions {
                Button {
                    loadMealDetails(for: meal)
                } label: {
                    Label("Lagre", systemImage: "square.grid.3x1.folder.fill.badge.plus")
                }
                .tint(.blue)
            }
        }
    }
    
    func rowPreviewImage(_ meal: MealAPI) -> some View {
        AsyncImage(url: URL(string: meal.strMealThumb)) { phase in
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
    
    func rowPreviewContent(_ meal: MealAPI) -> some View {
        VStack(alignment: .leading) {
            Text(meal.strMeal)
                .fontWeight(.semibold)
            Text(meal.strCategory ?? "Se mer informasjon.")
        }
    }
}


private extension SearchView {

    
    func loadMealDetails(for meal: MealAPI) {
        APIHelper.shared.fetchMealDetails(mealId: meal.idMeal) { mealDetails in
            CoreDataManager.shared.addReciepe(mealDetails: mealDetails, viewContext: viewContext)
        }
    }
    
    func loadMeals() {
        APIHelper.shared.loadMeals(selectedSearchOption: selectedSearchOption, searchText: searchText) { meals in
            self.searchResults = meals
        }
    }
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

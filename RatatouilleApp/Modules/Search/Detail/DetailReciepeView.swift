//
//  DetailReciepeView.swift
//  RatatouilleApp
//
//  Created by User on 2023-11-15.
//

import Foundation
import SwiftUI
import CoreData

struct DetailReciepeView: View {
    
    let mealId: String
    
    @State private var mealDetails: MealDetailsAPI?
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        if let mealDetails = mealDetails {
            VStack {
                List {
                    iconImageSection(mealDetails)
                    contentSection(mealDetails)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    saveButton
                }
            }
            .navigationTitle("Detaljer")
        } else {
            loadingView
        }
    }
}


private extension DetailReciepeView {

    
    func iconImageSection(_ mealDetails: MealDetailsAPI) -> some View {
        HStack {
            Spacer()
            if let imageURL = URL(string: mealDetails.strMealThumb) {
                AsyncImage(url: imageURL) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200, height: 200)
                            .cornerRadius(100)
                    case .failure:
                        Image(systemName: "photo.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200, height: 200)
                    @unknown default:
                        EmptyView()
                    }
                }
            }
            Spacer()
        }
        .background(Color(.systemGroupedBackground))
        .listRowBackground(Color(.systemGroupedBackground))
    }
    func contentSection(_ mealDetails: MealDetailsAPI) -> some View {
        Section(header: Text("Oppskrift")) {
            Text("Navn: \(mealDetails.strMeal)")
            Text("Kategori: \(mealDetails.strCategory ?? "Ukjent")")
            Text("Landområde: \(mealDetails.strArea ?? "Ukjent")")
            Text("Slik gjør du: \(mealDetails.strInstructions ?? "Ukjent")")
            Text("Tagger: \(mealDetails.strTags ?? "Ukjent")")
        }
    }
    var loadingView: some View {
        Text("Laster...")
            .onAppear {
                fetchMealDetails()
            }
    }
    var saveButton: some View {
        Button("Lagre") {
            saveReciepe()
            presentationMode.wrappedValue.dismiss()
        }
    }
}


private extension DetailReciepeView {
    func saveReciepe() {
        CoreDataManager.shared.addReciepe(mealDetails: mealDetails, viewContext: viewContext)
    }
    
    func fetchMealDetails() {
        APIHelper.shared.fetchMealDetails(mealId: mealId) { mealDetails in
            self.mealDetails = mealDetails
        }
    }
}



struct DetailReciepeView_Previews: PreviewProvider {
    static var previews: some View {
        DetailReciepeView(mealId: "12345")
    }
}

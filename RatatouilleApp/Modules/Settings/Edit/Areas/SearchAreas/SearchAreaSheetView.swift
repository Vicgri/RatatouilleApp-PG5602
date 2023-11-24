//
//  SearchAreaSheetView.swift
//  RatatouilleApp
//
//  Created by User on 2023-11-16.
//

import Foundation
import SwiftUI

struct SearchAreaSheetView: View {
    
    // MARK: - Properties
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    @State private var searchText = ""
    @State private var areas: [AreaAPI] = []
    
    
    // MARK: - Main View Configuration
    
    var body: some View {
        VStack {
            List {
                ForEach(areas, id: \.self) { area in
                    HStack {
                        AsyncImage(url: URL(string: "https://flagsapi.com/\(area.strArea.transformCountryName())/flat/64.png")) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 42, height: 42)
                            case .failure:
                                Image(systemName: "photo.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 42, height: 42)
                                    .foregroundColor(.blue)
                            @unknown default:
                                EmptyView()
                            }
                        }
                        .padding(.trailing, 5)
                        
                        Text(area.strArea)
                    }
                    .swipeActions {
                        Button {
                            saveArea(area)
                        } label: {
                            Label("Save", systemImage: "square.and.arrow.down")
                        }
                        .tint(.blue)
                    }
                }
            }
            .onAppear {
                fetchAreas()
            }
        }
        .navigationTitle("Søk")
    }
}


private extension SearchAreaSheetView {
    
    // MARK: - Main Logic
    
    func saveArea(_ area: AreaAPI) {
        CoreDataManager.shared.addArea(areaAPI: area, iconURL: "https://flagsapi.com/\(area.strArea.transformCountryName())/flat/64.png", viewContext: viewContext)
        presentationMode.wrappedValue.dismiss()
    }
    
    func fetchAreas() {
        APIHelper.shared.fetchAreas { areas in
            self.areas = areas
        }
    }
}


struct SearchAreaSheetView_Previews: PreviewProvider {
    static var previews: some View {
        SearchAreaSheetView()
    }
}

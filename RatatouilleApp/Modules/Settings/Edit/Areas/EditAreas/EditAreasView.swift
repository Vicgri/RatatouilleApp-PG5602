//
//  EditAreasView.swift
//  RatatouilleApp
//
//  Created by User on 2023-11-16.
//

import Foundation
import SwiftUI
import CoreData

struct EditAreasView: View {
    
    // MARK: - Properties
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Area.entity(), sortDescriptors: []) private var areas: FetchedResults<Area>
    
    @State private var isSearchSheetPresented = false
    
    
    // MARK: - Main View Configuration
    
    var body: some View {
        List {
            ForEach(areas, id: \.id) { area in
                if !area.isArchieved {
                    NavigationLink(destination: EditAreaView(area: area)) {
                        HStack {
                            AsyncImage(url: URL(string: area.iconURL!)) { phase in
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
                            Text(area.name!)
                        }
                    }
                    .swipeActions {
                        Button {
                            archieveArea(area)
                        } label: {
                            Label("Archive", systemImage: "archivebox.fill")
                        }
                        .tint(.blue)
                    }
                }
            }
        }
        .navigationTitle("Landområder") 
        .navigationBarItems(trailing: NavigationLink(destination: SearchAreaSheetView(), label: { Image(systemName: "plus") }))
    }
}


private extension EditAreasView {
    
    // MARK: - Main Logic
    
    func archieveArea(_ area: Area) {
        withAnimation {
            area.isArchieved = true
            area.dateArchived = Date()
        }
    }
}


struct EditAreasView_Previews: PreviewProvider {
    static var previews: some View {
        EditAreasView()
    }
}

//
//  EditAreaView.swift
//  RatatouilleApp
//
//  Created by User on 2023-11-23.
//

import Foundation
import SwiftUI

struct EditAreaView: View {
    
    // MARK: - Properties
    
    @ObservedObject var area: Area
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var editedName = ""
    
    
    // MARK: - Main View Configuration
    
    var body: some View {
        VStack {
            Form {
                Section {
                    HStack {
                        Spacer()
                        AsyncImage(url: URL(string: area.iconURL!)) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 80, height: 80)
                            case .failure:
                                Image(systemName: "photo.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 80, height: 80)
                                    .foregroundColor(.blue)
                            @unknown default:
                                EmptyView()
                            }
                        }
                        Spacer()
                    }
                    .listRowBackground(Color(.systemGroupedBackground))
                }
                Section {
                    TextField("Edit Area Name", text: $editedName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .onAppear {
                            setInitialName()
                        }
                }
            }
        }
        .navigationBarItems(trailing: Button("Save") {
            saveChanges()
        })
        .navigationTitle("Edit Area")
    }
}


private extension EditAreaView {
    
    // MARK: - Main Logic
    
    func setInitialName() {
        editedName = area.name ?? ""
    }
    
    func saveChanges() {
        area.name = editedName
        try? viewContext.save()
    }
}

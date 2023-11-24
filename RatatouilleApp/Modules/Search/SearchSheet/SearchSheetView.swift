//
//  SearchSheetView.swift
//  RatatouilleApp
//
//  Created by User on 2023-11-14.
//

import Foundation
import SwiftUI

struct SearchSheetView: View {
    
    // MARK: - Properties
    
    @AppStorage(AppStorageConstants.appearance) private var isDarkMode = false
    
    @State var searchOption: String = ""
    
    @Binding var searchText: String
    @Binding var isPresented: Bool
    
    // MARK: - Search Query Callback
    
    var onSearchTapped: () -> Void
    
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Søk her", text: $searchText)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Spacer()
            }
            .navigationTitle(searchOption)
            .navigationBarItems(
                leading: Button("Avbryt") {
                    isPresented = false
                }
                .foregroundColor(.accent),
                trailing: Button("Søk") {
                    onSearchTapped()
                    isPresented = false
                }
                .foregroundColor(.accent)
            )
            .navigationBarTitleDisplayMode(.inline)
            .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}


struct SearchSheetView_Previews: PreviewProvider {
    static var previews: some View {
        SearchSheetView(searchText: .constant("Eksempel søk tekst"), isPresented: .constant(true)) {}
    }
}

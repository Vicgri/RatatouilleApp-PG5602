//
//  SettingsView.swift
//  RatatouilleApp
//
//  Created by User on 2023-11-14.
//

import Foundation
import SwiftUI

struct SettingsView: View {
    

    @AppStorage(AppStorageConstants.appearance) private var isDarkMode = false

    
    var body: some View {
        NavigationView {
            Form {
                editRecipesPropertiesSection
                manageAppearanceSection
                manageArchivesSection
            }
            .navigationTitle("Innstillinger")
        }
    }
}


private extension SettingsView {

    
    var editRecipesPropertiesSection: some View {
        Section {
            NavigationLink(destination: EditAreasView()) {
                baseNavigationLinkCell("Rediger landomrader", iconName: "globe")
            }
            NavigationLink(destination: EditCategoriesView()) {
                baseNavigationLinkCell("Rediger kategorier", iconName: "square.filled.on.square")
            }
            NavigationLink(destination: EditIngredientsView()) {
                baseNavigationLinkCell("Rediger ingredienser", iconName: "carrot")
            }
        }
    }
    var manageAppearanceSection: some View {
        Section {
            HStack {
                Image(systemName: "moon.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.accent)
                    .frame(width: 20, height: 20)
                    .padding(.all, 1)
                    .padding(.leading, 8)
                    .padding(.trailing, 6)
                Toggle("Aktiver mørk modus", isOn: $isDarkMode)
                    .onChange(of: isDarkMode) { _ in
                        AppearanceManager.set(isDarkMode ? .dark : .light)
                    }
            }
        }
    }
    var manageArchivesSection: some View {
        Section {
            NavigationLink(destination: ManageArchivesView()) {
                baseNavigationLinkCell("Administrer arkiver", iconName: "archivebox.fill")
            }
        }
    }
    func baseNavigationLinkCell(_ content: String, iconName: String) -> some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(.accent)
                .frame(width: 40)
            Text(content)
                .multilineTextAlignment(.leading)
            Spacer()
        }
    }
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

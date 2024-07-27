//
//  SettingsTabView.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 17/10/2023.
//

import SwiftUI

struct SettingsTabView: View {
    @Binding var settings: Settings
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    NavigationLink(destination: AboutScreen()) {
                        Image(systemName: "info.circle")
                        Text("About")
                    }
                }
                Section("Show or hide input entry fields") {
                    ShowOrHideSectionsView(settings: $settings)
                }
                Section {
                    NavigationLink(destination: ManageDataScreen(settings: $settings)) {
                        Image(systemName: "cylinder.split.1x2")
                        Text("Manage data")
                    }
                }
                Section {
                    NavigationLink(destination: FeedbackForm()) {
                        Image(systemName: "bubble")
//                        Image(systemName: "envelope")
                        Text("Give developer feedback")
                    }
                }
                Section {
                    NavigationLink(destination: DeletedExpensesView()) {
                        Image(systemName: "trash")
                        Text("View deleted expenses")
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    @Environment(\.managedObjectContext) var moc
    @State var settings = Settings(moc: moc)
    return SettingsTabView(settings: $settings)
}

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
                        Text("About")
                    }
                }
                Section("Show or hide input entry fields") {
                    ShowOrHideSectionsView(settings: $settings)
                }
                Section {
                    NavigationLink(destination: ExportDataScreen()) {
                        Text("Export Data")
                    }
                }
                Section {
                    NavigationLink(destination: FeedbackForm()) {
                        Text("Give developer feedback")
                    }
                }
                
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    @State var settings = Settings()
    return SettingsTabView(settings: $settings)
}


/*
 ```swift
 if UserDefaults.includePaymentMethod {
   // payment method field
 }
 ```
 */

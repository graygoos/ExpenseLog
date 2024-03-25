//
//  SettingsTabView.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 17/10/2023.
//

import SwiftUI

struct SettingsTabView: View {
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Text("About")
                }
                Section("Show or hide input entry fields") {
                    ShowOrHideSectionsView()
                }
                
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsTabView()
}


/*
 ```swift
 if UserDefaults.includePaymentMethod {
   // payment method field
 }
 ```
 */

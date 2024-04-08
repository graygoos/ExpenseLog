//
//  ContentView.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 16/10/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var settings = Settings()
    
    var body: some View {
        
        TabView {
            TodayTabView(settings: $settings)
                .tabItem {
                    Label("Today", systemImage: "calendar")
                }
            HistoryTabView(settings: $settings)
                .tabItem {
                    Label("History", systemImage: "clock")
                }
            SettingsTabView(settings: $settings)
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}

#Preview {
    ContentView()
        .environment(\.managedObjectContext, ExpenseLogContainer(forPreview: true).persistentContainer.viewContext)
}

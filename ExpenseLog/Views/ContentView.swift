//
//  ContentView.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 16/10/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        TabView {
            TodayTabView()
                .tabItem {
                    Label("Today", systemImage: "calendar")
                }
            HistoryTabView()
                .tabItem {
                    Label("History", systemImage: "clock")
                }
            SettingsTabView()
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

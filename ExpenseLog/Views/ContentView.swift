//
//  ContentView.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 16/10/2023.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var settings: Settings?
    
    init() {
        // Initialize settings after moc is available
        _settings = State(initialValue: nil)
    }
    
    
    var body: some View {
        TabView {
            TodayTabView(settings: settingsBinding)
                .tabItem {
                    Label("Today", systemImage: "calendar")
                }
            HistoryTabView(settings: settingsBinding)
                .tabItem {
                    Label("History", systemImage: "clock")
                }
            SettingsTabView(settings: settingsBinding)
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
        .onAppear {
            // Initialize settings when the view appears
            settings = Settings(moc: moc)
        }
    }
    
    private var settingsBinding: Binding<Settings> {
        Binding(
            get: { settings ?? Settings(moc: moc) },
            set: { settings = $0 }
        )
    }
}

#Preview {
    ContentView()
        .environment(\.managedObjectContext, ExpenseLogContainer(forPreview: true).persistentContainer.viewContext)
}

//
//  ContentView.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 16/10/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ContentUnavailableView(label: {
                Label("No Expense logged.", systemImage: "creditcard.fill")
            }, description: {
                Text("You have not logged any expense today.")
            }, actions: {
                Button(action: {}) {
                    Text("Add Expense")
                }
            })
            .navigationTitle("ExpenseLog")
            .toolbar {
                ToolbarItem {
                    Button(action: {}) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        
        TabView {
            TodayView()
                .tabItem {
                    Label("Today", systemImage: "calendar")
                }
            HistoryView()
                .tabItem {
                    Label("History", systemImage: "clock")
                }
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}

#Preview {
    ContentView()
}

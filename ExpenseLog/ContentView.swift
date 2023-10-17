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
                Label("No Expenses", systemImage: "creditcard.fill")
            }, description: {
                Text("You have not logged any expenses today.")
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
    }
}

#Preview {
    ContentView()
}

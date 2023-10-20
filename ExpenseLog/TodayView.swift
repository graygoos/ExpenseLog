//
//  TodayView.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 17/10/2023.
//

import SwiftUI

struct TodayView: View {
    var body: some View {
        NavigationStack {
            ContentUnavailableView(label: {
                Label("No Expense logged.", systemImage: "creditcard.fill")
            }, description: {
                Text("Logged expenses will be listed here.")
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
    TodayView()
}

//
//  HistoryTabView.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 17/10/2023.
//

import SwiftUI

struct HistoryTabView: View {
    @State private var showModal = false
    
    var body: some View {
        NavigationStack {
            ContentUnavailableView(label: {
                Label("No Expense logged.", systemImage: "calendar.badge.clock")
            }, description: {
                Text("History of logged expenses will be shown here.")
            }, actions: {
            })
            .navigationTitle("History")
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        self.showModal.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                    .sheet(isPresented: $showModal, onDismiss: {
                        print("expenseEntryView dismissed")
                    }, content: {
                        ExpenseEntryView()
                    })
                }
            }
        }
    }
}

#Preview {
    HistoryTabView()
}

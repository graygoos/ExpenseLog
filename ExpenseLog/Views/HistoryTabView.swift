//
//  HistoryTabView.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 17/10/2023.
//

import SwiftUI

struct HistoryTabView: View {
    @Environment(\.managedObjectContext) var moc
    
    @State private var selectedFilter: HistoryFilter = .last7Days
    
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


enum HistoryFilter: String, CaseIterable {
    case yesterday = "Yesterday"
    case last7Days = "Last 7 Days"
    case lastMonth = "Last Month"
    case last3Months = "Last 3 Months"
    case last6Months = "Last 6 Months"
    case last12Months = "Last 12 Months"
}



#Preview {
    HistoryTabView()
}

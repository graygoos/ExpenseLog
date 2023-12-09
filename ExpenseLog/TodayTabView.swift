//
//  TodayTabView.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 17/10/2023.
// Group { if { ... } else { ...} } .sheet(...)

import SwiftUI

struct TodayTabView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest<ExpensesEntity>(sortDescriptors: [SortDescriptor(\.itemName)])
    private var expenses
    @State private var newExpense = false
    
    @State private var showModal = false
    
//    let dateFormatter = DateFormatter()
    let todayDate = Date.now
    
    
    
    var body: some View {
        NavigationStack {
            if !expenses.isEmpty {
                List {
                    ForEach(expenses) { expense in
                        VStack(alignment: .leading) {
                            Text(expense.viewItemName)
                                .font(.title)
                            Text(expense.viewItemDescription)
                                .font(.subheadline)
                            Text(expense.paymentType ?? "nil")
                        }
                    }
                }
                .navigationTitle("ExpenseLog")
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
            } else {
                TodayEmptyView()
            }
        }
    }
}

#Preview {
    Group {
        TodayTabView()
//            .environment(\.managedObjectContext, ExpenseLogContainer(forPreview: true).persistentContainer.viewContext)
    }
}

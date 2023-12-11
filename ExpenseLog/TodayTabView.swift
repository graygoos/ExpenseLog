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
    
    var currentDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyy"
        return dateFormatter.string(from: Date())
    }
    
    var body: some View {
        NavigationStack {
            if !expenses.isEmpty {
                List {
                    Section(header: TodayExpenseSectionHeader(), footer: TodayExpenseSectionFooter()) {
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
                }
                .navigationTitle(Text(currentDate))
                .listStyle(.plain)
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
            .environment(\.managedObjectContext, ExpenseLogContainer(forPreview: true).persistentContainer.viewContext)
    }
}

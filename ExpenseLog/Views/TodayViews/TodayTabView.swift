//
//  TodayTabView.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 17/10/2023.
// Group { if { ... } else { ...} } .sheet(...)

import SwiftUI

struct TodayTabView: View {
    @State private var navPath: [String] = []
    @Environment(\.managedObjectContext) var moc

    @FetchRequest<ExpensesEntity>(
        sortDescriptors: [],
            predicate: NSPredicate(format: "%K >= %@ AND %K <= %@", argumentArray: [#keyPath(ExpensesEntity.expenseDate), Date().startOfDay as NSDate, #keyPath(ExpensesEntity.expenseDate), Date().endDayOf as NSDate]),
            animation: .default
        ) private var expenses
    
    @State private var newExpense = false
    @State private var showModal = false
    
    let todayDate = Date()
    
    var currentDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyy"
        return dateFormatter.string(from: Date())
    }
    
    var body: some View {
        NavigationStack {
            if !expenses.isEmpty {
                List {
                    Section(header: TodayExpenseSectionHeader(), footer: TodayExpenseSectionFooter(expenses: expenses)) {
                        ForEach(expenses) { expense in
                            NavigationLink {
                                ExpenseDetailsView(expenses: expense)
                            } label: {
                                HStack {
                                    Text(expense.viewItemName)
                                        .truncationMode(.tail)
                                        .lineLimit(1)
                                    Spacer()
                                    Text(((expense.itemAmount))! as Decimal, format: .currency(code: expense.expenseCurrency ?? "NGN"))
                                }
                            }
                        }
                        .onDelete(perform: deleteExpense)
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
                                .imageScale(.large)
                        }
                        .sheet(isPresented: $showModal, onDismiss: {
                            print("expenseEntryView dismissed")
                        }, content: {
                            ExpenseEntryView()
                        })
                    }
//                    ToolbarItem(placement: .topBarLeading) {
//                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
//                            Image(systemName: "calendar.circle.fill")
//                                .imageScale(.large)
//                        })
//                    }
                }
            } else {
                TodayEmptyView()
            }
        }
    }
    
    private func deleteExpense(offsets: IndexSet) {
        for offset in offsets {
            moc.delete(expenses[offset])
        }
        try? moc.save()
    }
}

// Locale.current.currency?.identifier ?? "NGN"

#Preview {
    Group {
        TodayTabView()
            .environment(\.managedObjectContext, ExpenseLogContainer(forPreview: true).persistentContainer.viewContext)
    }
}

// ExpenseDetailsView
// ExpenseEditView
// ExpenseEntryView
// ExpenseFormView

// ExpenseFormModel

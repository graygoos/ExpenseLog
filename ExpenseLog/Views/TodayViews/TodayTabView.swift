//
//  TodayTabView.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 17/10/2023.
// Group { if { ... } else { ...} } .sheet(...)

import SwiftUI

struct TodayTabView: View {
    @Environment(\.managedObjectContext) var moc

    @FetchRequest<ExpensesEntity>(
        sortDescriptors: [],
            predicate: NSPredicate(format: "%K >= %@ AND %K <= %@", argumentArray: [#keyPath(ExpensesEntity.expenseDate), Date().startDay as NSDate, #keyPath(ExpensesEntity.expenseDate), Date().endDayOf as NSDate]),
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
                            HStack {
                                Text(expense.viewItemName)
                                Spacer()
                                Text(((expense.itemAmount))! as Decimal, format: .currency(code: expense.expenseCurrency ?? "NGN"))
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

// Locale.current.currency?.identifier ?? "NGN"

#Preview {
    Group {
        TodayTabView()
            .environment(\.managedObjectContext, ExpenseLogContainer(forPreview: true).persistentContainer.viewContext)
    }
}

extension Date {
    var startDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    var endDayOf: Date {
        return Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: self)!
    }
}

extension Decimal {
    func currencyFormattedString() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "NGN"
        
        return formatter.string(from: self as NSDecimalNumber) ?? ""
    }
}

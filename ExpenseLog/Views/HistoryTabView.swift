//
//  HistoryTabView.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 17/10/2023.
//

import SwiftUI

// Represent a group of expenses for a particular date
struct GroupedExpense: Identifiable {
    let id = UUID()
    let date: Date
    let expenses: [ExpensesEntity]
}

struct HistoryTabView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var showModal = false
    @State private var searchText = ""
    
    @Binding var settings: Settings
    
    @FetchRequest(entity: ExpensesEntity.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \ExpensesEntity.expenseDate, ascending: false)], animation: .default) var expenses: FetchedResults<ExpensesEntity>
    
    var body: some View {
        NavigationStack {
            if expenses.isEmpty {
                HistoryEmptyScreen(settings: $settings)
            } else {
                List {
                    if hasExpensesForRange(start: 1, end: 7) {
                        section(for: "Previous 7 Days", predicate: predicate(forRange: 1, end: 8))
                    }
                    if hasExpensesForRange(start: 8, end: 37) {
                        section(for: "Previous 30 Days", predicate: predicate(forRange: 8, end: 38))
                    }
                    if hasExpensesForRange(start: 38, end: 127) {
                        section(for: "Previous 90 Days", predicate: predicate(forRange: 38, end: 128))
                    }
                    if hasExpensesForRange(start: 128, end: 307) {
                        section(for: "Previous 180 Days", predicate: predicate(forRange: 128, end: 309))
                    }
                    if hasExpensesForRange(start: 309, end: 3650) {  // Roughly 10 years
                        section(for: "Older", predicate: predicateForOlderThan(days: 309))
                    }
                }
                .navigationTitle("History")
                .searchable(text: $searchText)
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
                            ExpenseEntryView(settings: $settings)
                        })
                    }
                }
            }
        }
    }           // ❓always test for boundaries // view that shows all the records
    
    private var shouldShowEmptyState: Bool {
        return !hasExpensesForRange(start: 0, end: 3650)  // Check for any expenses in the last ~10 years
    }
    
    private func hasExpensesForRange(start: Int, end: Int) -> Bool {
        let calendar = Calendar.current
        let now = Date()
        let startDate = calendar.date(byAdding: .day, value: -end, to: now)!
        let endDate = calendar.date(byAdding: .day, value: -start, to: now)!
        
        return expenses.contains { expense in
            guard let expenseDate = expense.expenseDate else { return false }
            return expenseDate >= startDate && expenseDate < endDate
        }
    }
    
    private func hasExpensesOlderThan(_ days: Int) -> Bool {
        let calendar = Calendar.current
        let now = Date()
        let endDate = calendar.date(byAdding: .day, value: -days, to: now)!
        
        return expenses.contains { expense in
            guard let expenseDate = expense.expenseDate else { return false }
            let expenseDateStartOfDay = calendar.startOfDay(for: expenseDate)
            return expenseDateStartOfDay < endDate
        }
        
    }
    
    // Create a predicate for expenses in the last N days
    private func predicate(forRange start: Int, end: Int) -> NSPredicate {
        let calendar = Calendar.current
        let now = Date()
        let startDate = calendar.date(byAdding: .day, value: -end, to: now)!
        let endDate = calendar.date(byAdding: .day, value: -start, to: now)!
        
        if searchText.isEmpty {
            return NSPredicate(format: "expenseDate >= %@ AND expenseDate < %@", startDate as NSDate, endDate as NSDate)
        }
        
        return NSPredicate(format: "expenseDate >= %@ AND expenseDate < %@ AND (itemName CONTAINS[cd] %@ OR itemDescription CONTAINS[cd] %@ OR itemUnit CONTAINS[cd] %@ OR payee CONTAINS[cd] %@ OR expenseLocation CONTAINS[cd] %@ OR paymentType CONTAINS[cd] %@)", startDate as NSDate, endDate as NSDate, searchText, searchText, searchText, searchText, searchText, searchText)
    }
    
    // Function to create a predicate for expenses for older than  a given number of days
    private func predicateForOlderThan(days: Int) -> NSPredicate {
        let calendar = Calendar.current
        let now = Date()
        let date = calendar.date(byAdding: .day, value: -days, to: now)!
        
        if searchText.isEmpty {
            return NSPredicate(format: "expenseDate < %@", date as NSDate)
        }
        
        return NSPredicate(format: "expenseDate < %@ AND (itemName CONTAINS[cd] %@ OR itemDescription CONTAINS[cd] %@ OR itemUnit CONTAINS[cd] %@ OR payee CONTAINS[cd] %@ OR expenseLocation CONTAINS[cd] %@ OR paymentType CONTAINS[cd] %@)", date as NSDate, searchText, searchText, searchText, searchText, searchText, searchText)
    }
    
    // Create a section for specific time range
    // specify sort - sort before grouping❓
    private func section(for title: String, predicate: NSPredicate) -> some View {
        let filteredExpenses = expenses.filter { predicate.evaluate(with: $0) }
        
        let groupedExpenses = self.groupedExpenses(for: filteredExpenses)
        
        return Section(header: Text(title)) {
            ForEach(groupedExpenses, id: \.date) { groupedExpense in
                NavigationLink(destination: ExpenseListView(date: groupedExpense.date, settings: $settings)) {
                    VStack(alignment: .leading) {
                        Text(groupedExpense.date.formattedDay) //format date - locale
                        HStack {
                            Text("^[\(groupedExpense.expenses.count) Expense](inflect: true)")
                                .font(.footnote)
                                .foregroundStyle(.gray)
                            Spacer()
                            Text("Total: \(groupedExpense.expensesTotal, format: .currency(code: "NGN"))")
                                .font(.footnote)
                                .foregroundStyle(.gray)
                        }
                    }
                }
            }
            .onDelete(perform: deleteExpense)
        }
    }
    
    private func deleteExpense(offsets: IndexSet) {
        for offset in offsets {
            moc.delete(expenses[offset])
        }
        try? moc.save()
    }
    
    // Function to group expenses by date
    private func groupedExpenses(for expenses: [ExpensesEntity]) -> [GroupedExpense] {
        let groupedDictionary = Dictionary(grouping: expenses) { (expense) -> Date in
            guard let date = expense.expenseDate else {
//                return Date()
                return Calendar.current.startOfDay(for: Date())
            }
            return Calendar.current.startOfDay(for: date)
        }
        
        let sortedDays = groupedDictionary.keys.sorted { lhs, rhs in
            lhs > rhs
        }
        
        let sortedGroupExpenses = sortedDays.map { day in
            GroupedExpense(date: day, expenses: groupedDictionary[day] ?? [])
        }
        
        return sortedGroupExpenses
    }
}

#Preview {
    @Environment(\.managedObjectContext) var moc
    @State var settings = Settings(moc: moc)
    return HistoryTabView(settings: $settings)
}


// Extension to calculate total amount for grouped expenses
extension GroupedExpense {
    var expensesTotal: Decimal {
        expenses.reduce(Decimal(0)) { total, expense in
            (total as NSDecimalNumber).adding(expense.itemAmount ?? 0).decimalValue
        }
    }
}

/* 4 types of comments:
 1. documentation comments
 2. informative comments
 3. commented out code - not going into commits
 4. working comments - things that need to fixed or addressed, not necessarily going into commits - issues
 */

/*
 
 */

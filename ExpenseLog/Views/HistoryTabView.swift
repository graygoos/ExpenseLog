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
    
    @State private var showingDeleteAlert = false
    @State private var dateToDelete: Date?
    
    @State private var expandedSections: Set<String> = []
    
    @Binding var settings: Settings
    
    @FetchRequest(entity: ExpensesEntity.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \ExpensesEntity.expenseDate, ascending: false)], animation: .default) var expenses: FetchedResults<ExpensesEntity>
    
    var body: some View {
        NavigationStack {
            if expenses.isEmpty {
                HistoryEmptyScreen(settings: $settings)
            } else {
                List {
                    if hasExpensesForRange(start: 1, end: 7) {
                        collapsibleSection(title: "Previous 7 Days", predicate: predicate(forRange: 1, end: 8))
                    }
                    if hasExpensesForRange(start: 8, end: 37) {
                        collapsibleSection(title: "Previous 30 Days", predicate: predicate(forRange: 8, end: 38))
                    }
                    if hasExpensesForRange(start: 38, end: 127) {
                        collapsibleSection(title: "Previous 90 Days", predicate: predicate(forRange: 38, end: 128))
                    }
                    if hasExpensesForRange(start: 128, end: 307) {
                        collapsibleSection(title: "Previous 180 Days", predicate: predicate(forRange: 128, end: 309))
                    }
                    if hasExpensesForRange(start: 309, end: 3650) {
                        collapsibleSection(title: "Older", predicate: predicateForOlderThan(days: 309))
                    }
                }
                .listStyle(.sidebar )
                .navigationTitle("History")
                .searchable(text: $searchText)
                .toolbar {
                    ToolbarItem {
                        Button(action: {
                            self.showModal.toggle()
                        }) {
                            Image(systemName: "plus")
                        }
                    }
                }
                .sheet(isPresented: $showModal) {
                    ExpenseEntryView(settings: $settings)
                }
            }
        }
        .alert("Delete Expenses", isPresented: $showingDeleteAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                if let date = dateToDelete {
                    let expensesToDelete = expenses.filter { Calendar.current.isDate($0.expenseDate!, inSameDayAs: date) }
                    for expense in expensesToDelete {
                        moc.delete(expense)
                    }
                    try? moc.save()
                }
            }
        } message: {
            Text("Are you sure you want to delete all expenses for this day?")
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
    
    private func collapsibleSection(title: String, predicate: NSPredicate) -> some View {
        Section {
            if expandedSections.contains(title) {
                let filteredExpenses = expenses.filter { predicate.evaluate(with: $0) }
                let groupedExpenses = self.groupedExpenses(for: filteredExpenses)
                
                ForEach(groupedExpenses, id: \.date) { groupedExpense in
                    NavigationLink(destination: ExpenseListView(date: groupedExpense.date, settings: $settings)) {
                        VStack(alignment: .leading) {
                            Text(groupedExpense.date.formattedDay)
                            HStack {
                                Text("^[\(groupedExpense.expenses.count) Expense](inflect: true)")
                                    .font(.footnote)
                                    .foregroundStyle(.gray)
                                Spacer()
                                Text(formatCurrencies(for: groupedExpense.expenses))
                                    .font(.footnote)
                                    .foregroundStyle(.gray)
                                    .lineLimit(1)
                            }
                        }
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Button(role: .destructive) {
                            deleteExpense(for: groupedExpense.date)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                }
            }
        } header: {
            HStack {
                Text(title)
                Spacer()
                Image(systemName: expandedSections.contains(title) ? "chevron.down" : "chevron.right")
            }
            .contentShape(Rectangle())
            .onTapGesture {
                if expandedSections.contains(title) {
                    expandedSections.remove(title)
                } else {
                    expandedSections.insert(title)
                }
            }
        }
    }
    
    private func formatCurrencies(for expenses: [ExpensesEntity]) -> String {
        let currencyTotals = expenses.reduce(into: [String: Decimal]()) { result, expense in
            guard let currency = expense.expenseCurrency, let amount = expense.itemAmount as Decimal? else { return }
            result[currency, default: 0] += amount
        }
        
        let defaultCurrency = settings.defaultCurrency
        
        let sortedCurrencies = currencyTotals.keys.sorted { lhs, rhs in
            if lhs == defaultCurrency { return true }
            if rhs == defaultCurrency { return false }
            return lhs < rhs
        }
        
        let formattedTotals = sortedCurrencies.prefix(2).map { currency in
            let total = currencyTotals[currency] ?? 0
            let symbol = Locale.current.currencySymbol(forCurrencyCode: currency) ?? currency
            return "\(symbol)\(total)"
        }
        
        if sortedCurrencies.count <= 2 {
            return formattedTotals.joined(separator: ", ")
        } else {
            return formattedTotals.joined(separator: ", ") + "..."
        }
    }
    
    private func deleteExpense(for date: Date) {
        dateToDelete = date
        showingDeleteAlert = true
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

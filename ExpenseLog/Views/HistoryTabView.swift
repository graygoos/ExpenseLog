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
    
    @FetchRequest(entity: ExpensesEntity.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \ExpensesEntity.expenseDate, ascending: false)], animation: .default) var expenses: FetchedResults<ExpensesEntity>
    
//    var expense: ExpensesEntity
    
    var body: some View {
        NavigationStack {
            List {          // offset ❓
                section(for: "Previous 7 Days", predicate: predicate(forLastNDays: 7, offset: 1)) // 1
                section(for: "Previous 30 Days", predicate: predicate(forLastNDays: 31, offset: 8)) // 8
                section(for: "Previous 90 Days", predicate: predicate(forLastNDays: 91, offset: 31)) // 38
                section(for: "Previous 180", predicate: predicate(forLastNDays: 181, offset: 91)) // 128
                section(for: "Older", predicate: predicate(forOlderThan: 181))
            }
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
//                        ExpenseDetailsView(expenses: expense)
                    })
                }
            }
        }
    }           // ❓always test for boundaries // view that shows all the records
    
    // Create a predicate for expenses in the last N days
    private func predicate(forLastNDays days: Int, offset: Int = 1) -> NSPredicate {
        let calendar = Calendar.current
        let now = Date()
        let startDate = calendar.date(byAdding: .day, value: -days, to: now)!
//        let endDate = now
        let endDate = calendar.date(byAdding: .day, value: -offset, to: now)!
        
        return NSPredicate(format: "expenseDate >= %@ AND expenseDate < %@", startDate as NSDate, endDate as NSDate)
    }
    
    // Function to create a predicate for expenses for older than  a given number of days
    private func predicate(forOlderThan days: Int) -> NSPredicate {
        let calendar = Calendar.current
        let now = Date()
        let endDate = calendar.date(byAdding: .day, value: -days, to: now)!
        
        return NSPredicate(format: "expenseDate < %@", endDate as NSDate)
    }
    
    // Create a section for specific time range
    // specify sort - sort before grouping❓
    private func section(for title: String, predicate: NSPredicate) -> some View {
        let filteredExpenses = expenses.filter { predicate.evaluate(with: $0) }
        
        let groupedExpenses = self.groupedExpenses(for: filteredExpenses)
        
        return Section(header: Text(title)) {
            ForEach(groupedExpenses, id: \.date) { groupedExpense in
                NavigationLink(destination: ExpenseListView(date: groupedExpense.date)) {
                    Text(groupedExpense.date.formattedDay) // format date
                }
            }
        }
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
        
//        let sortedGroupExpenses = groupedDictionary.map { (key, value) in
//            let sortedExpenses = value.sorted { $0.expenseDate ?? Date() > $1.expenseDate ?? Date() }
//            return GroupedExpense(date: key, expenses: sortedExpenses)
//        }
        let sortedDays = groupedDictionary.keys.sorted { lhs, rhs in
            lhs > rhs
        }
        
        let sortedGroupExpenses = sortedDays.map { day in
            GroupedExpense(date: day, expenses: groupedDictionary[day] ?? [])
        }
        
        return sortedGroupExpenses
        
//        return groupedDictionary.map { (key, value) in
//            return GroupedExpense(date: key, expenses: value)
//        }
    }
    
}

#Preview {
    HistoryTabView()
}


/* 4 types of comments:
 1. documentation comments
 2. informative comments
 3. commented out code - not going into commits
 4. working comments - things that need to fixed or addressed, not necessarily going into commits - issues
 */

/*
 
 */

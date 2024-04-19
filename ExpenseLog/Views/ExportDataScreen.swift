//
//  ExportDataScreen.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 25/03/2024.
//

import SwiftUI
import CoreData

struct ExportDataScreen: View {
    @Environment(\.managedObjectContext) var moc
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var filteredExpenses: FetchRequest<ExpensesEntity>?
    
    @FetchRequest(
        entity: ExpensesEntity.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \ExpensesEntity.expenseDate, ascending: true)]
    ) var expenses: FetchedResults<ExpensesEntity>

    var body: some View {
        VStack {
            DatePicker("Start Date", selection: $startDate, in: ...endDate, displayedComponents: .date)
                .onChange(of: startDate) { oldValue, newValue in
                    updateFetchRequestPredicate()
                }
                .onAppear {
                    // Set the default start date to the date of the first expense
                    if let firstExpenseDate = expenses.first?.expenseDate {
                        startDate = firstExpenseDate
                        updateFetchRequestPredicate()
                    }
                }

            DatePicker("End Date", selection: $endDate, in: startDate..., displayedComponents: .date)
                .onChange(of: endDate) { oldValue, newValue in
                    updateFetchRequestPredicate()
                }
            Spacer()
            Text("\(expenses.count) expenses logged in ExpenseLog")
            Spacer()
            ShareLink(item: generateCSV() ?? URL(string: "https://example.com")!) {
                Label("Export CSV", systemImage: "square.and.arrow.up.fill")
            }
            Spacer()
            Spacer()
        }
        .padding()
    }
    
    func updateFetchRequestPredicate() {
        let predicate = NSPredicate(format: "(expenseDate >= %@) AND (expenseDate <= %@)", argumentArray: [startDate, endDate])
        filteredExpenses = FetchRequest(
            entity: ExpensesEntity.entity(),
            sortDescriptors: [NSSortDescriptor(keyPath: \ExpensesEntity.expenseDate, ascending: true)],
            predicate: predicate
        )
    }

    
//    func updateFetchRequestPredicate() {
//        let predicate = NSPredicate(format: "(expenseDate >= %@) AND (expenseDate <= %@)", argumentArray: [startDate, endDate])
//        filteredExpenses = FetchRequest(
//            entity: ExpensesEntity.entity(),
//            sortDescriptors: [NSSortDescriptor(keyPath: \ExpensesEntity.expenseDate, ascending: true)],
//            predicate: predicate
//        )
//    }

    
    func generateCSV() -> URL? {
        // Filter expenses based on the selected date range
        let filteredExpenses = expenses.filter { expense in
            if let expenseDate = expense.expenseDate {
                return expenseDate >= startDate && expenseDate <= endDate
            }
            return false
        }
        
        // Sort the filtered expenses by date
        let sortedExpenses = filteredExpenses.sorted { expense1, expense2 in
            guard let date1 = expense1.expenseDate, let date2 = expense2.expenseDate else {
                return false
            }
            return date1 < date2
        }
        
        // Create CSV content
//        var csvString = "Expense Date, Item Amount\n"
        var csvString = "Expense Date, Item Name, Currency, Amount\n"
        for expense in sortedExpenses {
            if let expenseDate = expense.expenseDate {
                csvString += "\(expenseDate), \(String(describing: expense.itemAmount))\n"
            }
        }
        
        // Print the contents of the CSV file
        print("CSV File Content:")
        print(csvString)
        
        // Write the CSV content to a file
        do {
            let path = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let fileURL = path.appendingPathComponent("Expenses.csv")
            
            // Write CSV content to file
            try csvString.write(to: fileURL, atomically: true, encoding: .utf8)
            return fileURL
        } catch {
            print("Error generating CSV file: \(error)")
            return nil
        }
    }
}


/*
enum ExportFormat {
    case csv
    case json
}

struct Expenses: Identifiable {
    var id = UUID()
    var expenseDate: Date
    var ItemAmount: Double
}

struct ExportDataScreen: View {
    @Environment(\.managedObjectContext) var moc
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var exportFormat = ExportFormat.csv
    @State private var filteredExpenses: FetchRequest<ExpensesEntity>?
    
//    @FetchRequest(entity: ExpensesEntity.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \ExpensesEntity.expenseDate, ascending: true)]) var expenses: FetchedResults<ExpensesEntity>
    @FetchRequest(
        entity: ExpensesEntity.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \ExpensesEntity.expenseDate, ascending: true)]
    ) var expenses: FetchedResults<ExpensesEntity>

    var body: some View {
        VStack {
            DatePicker("Start Date", selection: $startDate, in: ...endDate, displayedComponents: .date)
                .onChange(of: startDate) { _ in
                    updateFetchRequestPredicate()
                }
                .onAppear {
                    // Set the default start date to the date of the first expense
                    if let firstExpenseDate = expenses.first?.expenseDate {
                        startDate = firstExpenseDate
                        updateFetchRequestPredicate()
                    }
                }

            DatePicker("End Date", selection: $endDate, in: startDate..., displayedComponents: .date)
                .onChange(of: endDate) { _ in
                    updateFetchRequestPredicate()
                }
            Spacer()
            Text("\(expenses.count) expenses logged in ExpenseLog")
            Spacer()
            ShareLink(item: generateCSV(expenses: expenses.map { $0 }) ?? URL(string: "https://example.com")!) {
                Label("Export CSV", systemImage: "square.and.arrow.up.fill")
            }
            Spacer()
            Spacer()
        }
        .padding()
        .onChange(of: startDate) { oldValue, newValue in
            updateFetchRequestPredicate()
        }
        .onChange(of: endDate) { oldValue, newVAlue in
            updateFetchRequestPredicate()
        }
    }
    

    func updateFetchRequestPredicate() {
        let predicate = NSPredicate(format: "(expenseDate >= %@) AND (expenseDate <= %@)", argumentArray: [startDate, endDate])
        filteredExpenses = FetchRequest(
            entity: ExpensesEntity.entity(),
            sortDescriptors: [NSSortDescriptor(keyPath: \ExpensesEntity.expenseDate, ascending: true)],
            predicate: predicate
        )
    }

    
    func generateCSV(expenses: [ExpensesEntity]) -> URL? {
        // Filter expenses based on the selected date range
        let filteredExpenses = expenses.filter { expense in
            if let expenseDate = expense.expenseDate {
                return expenseDate >= startDate && expenseDate <= endDate
            }
            return false
        }
        
        // Sort the filtered expenses by date
        let sortedExpenses = filteredExpenses.sorted { expense1, expense2 in
            guard let date1 = expense1.expenseDate, let date2 = expense2.expenseDate else {
                return false
            }
            return date1 < date2
        }
        
        // Create CSV content
        var csvString = "Expense Date, Item Amount\n"
        for expense in sortedExpenses {
            if let expenseDate = expense.expenseDate {
                csvString += "\(expenseDate), \(expense.itemAmount)\n"
            }
        }
        
        // Print the contents of the CSV file
        print("CSV File Content:")
        print(csvString)
        
        // Write the CSV content to a file
        do {
            let path = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let fileURL = path.appendingPathComponent("Expenses.csv")
            
            // Write CSV content to file
            try csvString.write(to: fileURL, atomically: true, encoding: .utf8)
            return fileURL
        } catch {
            print("Error generating CSV file: \(error)")
            return nil
        }
    }
}
*/
#Preview {
    ExportDataScreen()
}

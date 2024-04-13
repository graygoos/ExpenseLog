//
//  ExportDataScreen.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 25/03/2024.
//

import SwiftUI
import CoreData

enum ExportFormat {
    case csv
    case json
}

struct Expenses: Identifiable {
    var id = UUID()
    var expenseDate: Date
    var ItemAmount: Double
//    var category: String?
//    let expenses: [ExpensesEntity]
}

struct ExportDataScreen: View {
    @Environment(\.managedObjectContext) var moc
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var exportFormat = ExportFormat.csv
    
    @FetchRequest(entity: ExpensesEntity.entity(), sortDescriptors: []) var expenses: FetchedResults<ExpensesEntity>
        
    
//    @FetchRequest(entity: ExpensesEntity.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \ExpensesEntity.expenseDate, ascending: false)], animation: .default) var expenses: FetchedResults<ExpensesEntity>
    
    var body: some View {
        VStack {
            DatePicker("Start Date", selection: $startDate, in: ...endDate, displayedComponents: .date)
                .onChange(of: startDate) { oldValue ,newValue in
                    // Ensure the start date does not go beyond the end date
                    if newValue > endDate {
                        startDate = endDate
                    }
                    
                }
                .onAppear {
                    // Set the default start date to the date of the first expense
                    if let firstExpenseDate = expenses.first?.expenseDate {
                        startDate = firstExpenseDate
                    }
                }
            // earliest date in database
            // put limiter, you cannot pick a date earlier than start date above
            DatePicker("End Date", selection: $endDate, displayedComponents: .date)
            Text("Found \(expenses.count)")
            Picker("Export Format", selection: $exportFormat) {
                Text("CSV").tag(ExportFormat.csv)
                Text("JSON").tag(ExportFormat.json)
            }
            Button("Export", systemImage: "square.and.arrow.up.fill") {
                exportData()
            }
        }
        .padding()
    }
    
    func exportData() {
        // Fetch data from Core Data based on date range
        let fetchRequest: NSFetchRequest<ExpensesEntity> = ExpensesEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "(expenseDate >= %@) AND (expenseDate <= %@)", startDate as NSDate, endDate as NSDate)
        
        do {
            let expenses = try moc.fetch(fetchRequest)
            if exportFormat == .csv {
                exportCSV(expenses: expenses)
            } else if exportFormat == .json {
                exportJSON(expenses: expenses)
            }
        } catch {
            print("Error fetching data: \(error)")
        }
    }
    
    func exportCSV(expenses: [ExpensesEntity]) {
        // Convert expenses array into CSV format
        var csvString = "Date, Amount\n"
        for expense in expenses {
            csvString += "\(expense.expenseDate ?? Date()), \(expense.itemAmount ?? 0)) \n"
        }
        // Save or share csvString as needed
    }
    
    func exportJSON(expenses: [ExpensesEntity]) {
        /*
        // Convert expenses array into JSON format
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(expenses)
            // Save or share jsonData as needed
        } catch {
            print("Error encoding JSON: \(error)")
        }
         */
    }
}

#Preview {
    ExportDataScreen()
}

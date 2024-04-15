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
    
    @FetchRequest(entity: ExpensesEntity.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \ExpensesEntity.expenseDate, ascending: true)]) var expenses: FetchedResults<ExpensesEntity>
        
    
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
//                exportJSON(expenses: expenses)
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
        print(csvString)
        // Save or share csvString as needed
        
    }
    
    /*
    func exportJSON(expenses: [ExpensesEntity]) {
        // Convert expenses array into JSON format
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(expenses)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print(jsonString)
            }
            // Save or share jsonData as needed
            
        } catch {
            print("Error encoding JSON: \(error)")
        }
    }
 */
    /*
    func shareFile(content: String, type: String) {
        // Create a temporary file URL
        guard let tempURL = NSURL(fileURLWithPath: NSTemporaryDirectory().appendingPathComponent("export.csv") else {
            return
        }
                                  
                                  do {
            // Write the content to the temporary file
            try content.write(to: tempURL, atomically: true, encoding: .utf8)
            
            // Create a UIActivityViewController to share the file
            let activityViewController = UIActivityViewController(activityItems: [tempURL], applicationActivities: nil)
            
            // Present the UIActivityViewController
            UIApplication.shared.windows.first?.rootViewController?.present(activityViewController, animated: true, completion: nil)
        } catch {
            print("Error writing file: \(error)")
        }
                                  }
     */
}

#Preview {
    ExportDataScreen()
}

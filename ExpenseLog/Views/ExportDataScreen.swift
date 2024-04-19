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
}

struct ExportDataScreen: View {
    @Environment(\.managedObjectContext) var moc
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var exportFormat = ExportFormat.csv
    
    @FetchRequest(entity: ExpensesEntity.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \ExpensesEntity.expenseDate, ascending: true)]) var expenses: FetchedResults<ExpensesEntity>
        
    
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
    }
    
    func generateCSV(expenses: [ExpensesEntity]) -> URL? {
        // heading of CSV file.
        let heading = "Expense Date, Item Amount\n"
        
        // file rows
        let rows = expenses.map { "\($0.expenseDate ?? Date()),\($0.itemAmount)\n" }
        
        // rows to string data
        let stringData = heading + rows.joined()
        
        // Print the contents of the CSV file
        print("CSV File Content:")
        print(stringData)
        
        do {
            let path = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let fileURL = path.appendingPathComponent("Expenses.csv")
            
            // append string data to file
            try stringData.write(to: fileURL, atomically: true , encoding: .utf8)
            return fileURL
        } catch {
            print("Error generating CSV file: \(error)")
            return nil
        }
    }
}

#Preview {
    ExportDataScreen()
}

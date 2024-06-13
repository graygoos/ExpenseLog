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
    @Binding var settings: Settings
    
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
    
    func generateCSV() -> URL? {
        // Define CSV header based on user's selected settings
        let csvHeader = "No., Date, Item Name, Expense Amount, Description, Payment Method, Recurring Expense, Budgeted, Quantity, Unit, Vendor, Location, Category, Frequency\n"

        // Filter and sort expenses
        let filteredExpenses = expenses.filter { expense in
            if let expenseDate = expense.expenseDate {
                return expenseDate >= startDate && expenseDate <= endDate
            }
            return false
        }
        
        // Sort the filtered expenses by date
        let sortedExpenses = filteredExpenses.sorted { expense1, expense2 in
            if let date1 = expense1.expenseDate, let date2 = expense2.expenseDate {
                return date1 > date2
            }
            return false
        }
        
        // Create CSV content
        var csvString = csvHeader
        for (index, expense) in sortedExpenses.enumerated() {
            // Format optional values
            let itemName = expense.itemName ?? ""
            let expenseDate = expense.expenseDate?.description ?? ""
            let itemDescription = expense.itemDescription ?? ""
            let paymentMethod = expense.paymentType ?? ""
            let recurringExpense = expense.recurringExpense ? "Yes" : "No"
            let budgeted = expense.isBudgeted ? "Yes" : "No"
            let quantity = settings.showQuantitySection ? "\(expense.itemQuantity)" : ""
            let unit = settings.showQuantitySection ? "\(expense.itemUnit ?? "")" : ""
            let vendor = settings.showVendorSection ? "\(expense.payee ?? "")" : ""
            let location = settings.showLocationSection ? "\(expense.expenseLocation ?? "")" : ""
            let category = settings.showCategorySection ? "\(expense.expenseCategory ?? "")" : ""
            let frequency = settings.showFrequencySection ? "\(expense.expenseFrequency ?? "")" : ""
            let amount = "\(expense.expenseCurrency ?? "") \(expense.itemAmount ?? 0)"
            
            // Create CSV row
            let expenseRow = "\(index + 1), \(expenseDate), \(itemName), \(amount), \(itemDescription), \(paymentMethod), \(recurringExpense), \(budgeted), \(quantity), \(unit), \(vendor), \(location), \(category), \(frequency)\n"
            
            csvString += expenseRow
        }
        
        // Print and write CSV content to file
        print("CSV File Content:")
        print(csvString)
        
        do {
            let path = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let fileURL = path.appendingPathComponent("Expenses for \(formattedDate(startDate)) to \(formattedDate(endDate)).csv")
            
            // Write CSV content to file
            try csvString.write(to: fileURL, atomically: true, encoding: .utf8)
            return fileURL
        } catch {
            print("Error generating CSV file: \(error)")
            return nil
        }
    }
    
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd_HH-mm-ss"
        return formatter.string(from: date)
    }
}


/*
 
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
    @Environment(\.managedObjectContext) var moc
    @State var settings = Settings(moc: moc)
    return ExportDataScreen(settings: $settings)
}

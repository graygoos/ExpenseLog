//
//  ExpenseParameters.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 21/03/2024.
//

import Foundation
import CoreData

@Observable
class ExpenseParameters {
    var moc: NSManagedObjectContext?
    var expense: ExpensesEntity? {
        didSet {
            self.itemName = expense?.itemName ?? ""
            self.itemAmount = Double(expense?.viewItemAmount ?? "0")!
            self.itemDescription = expense?.viewItemDescription ?? ""
            self.itemUnit = expense?.itemUnit ?? ""
            self.payee = expense?.viewPayee ?? ""
            self.expenseLocation = expense?.viewExpenseLocation ?? ""
            self.itemQuantity = Double(expense?.viewItemQuantity ?? "0")!
            self.paymentType = expense?.viewPaymentType ?? ""
            self.expenseCurrency = Locale.current.currency?.identifier ?? "USD"
            self.expenseCategory = expense?.expenseCategory ?? ""
            self.expenseFrequency = expense?.expenseFrequency
            if let dateString = expense?.viewExpenseDate, dateString != "N/A" {
                let formatter = ISO8601DateFormatter()
                formatter.formatOptions = [.withInternetDateTime];
                formatter.timeZone = TimeZone.current
                if let date = formatter.date(from: dateString) {
                    self.expenseDate = date
                    print("Parsed Expense Date in UTC: \(date.toISO8601String())")
                }
            } else {
                self.expenseDate = Date()
            }
        }
    }
    
    init(moc: NSManagedObjectContext? = nil) {
        self.moc = moc
        self.expenseCurrency = Locale.current.currency?.identifier ?? "USD"
        print("expenseParameters init 🤣 ") // 3
    }
    
    var itemName = ""
    var itemAmount: Double = 0.00
    var itemDescription = ""
    var itemUnit = "Non"
    var payee = ""
    var expenseLocation = ""
    var itemQuantity: Double = 1
    var paymentType = "Debit Card"
    var expenseDate = Date()
    var recurringExpense = false
    var isBudgeted = false
    var expenseFrequency: String?
    var expenseCurrency = "NGN"
    var expenseCategory = "Non"
    
    init(expenseDate: Date = Date()) {
        self.expenseDate = expenseDate
        self.expenseCurrency = Locale.current.currency?.identifier ?? "USD"
    }
    
    var itemUnits = ["Non", "Pack", "Tin", "Carton", "Crate", "Bag", "Box", "Bar", "Loaf", "Card", "Bottle", "Jar", "Can", "Bowl", "Piece", "Plate", "Case", "Bulk Container", "Pouch", "Blister Pack", "Wrap", "Wrapper", "Foil", "Container", "Canister", "Envelope", "Cellophane/Plastic wrap", "Bushel", "Pair", "Portion", "Kilogram", "Roll", "Pound", "Ounce", "Litre", "Centilitre", "Millilitre", "Yard", "Meter", "Tube", "Bucket", "Basket", "Sachet", "Cup", "Page", "Stick", "Measure", "Day", "Week", "Month", "Year", "Unit", "Other"]
    
    var paymentMethod = ["Debit Card", "Cash", "Electronic Funds Transfer", "Credit Card", "Cheque",  "Cryptocurrency", "Bank App", "USSD"]
    
    var frequency: [String?] = [nil, "Hourly", "Daily", "Weekly", "Monthly", "Quarterly", "Annually", "One-time"]
    
    var category = ["Non", "Food & Dining", "Groceries", "Transportation", "Utilities (Electricity, Water, Gas)", "Rent",
                    "Mortgage", "Entertainment", "Healthcare", "Health & Fitness", "Shopping", "Personal Care", "Travel", "Insurance", "Education", "Debt Payments", "Investments", "Gifts & Donations", "Home Maintenance", "Pet Care", "Taxes", "Subscriptions & Memberships", "Miscellaneous"]
    
    
    var showModal = false
    
    func persistExpense() {
        guard let moc else {
            return
        }
        let expense = self.expense ?? ExpensesEntity(context: moc)
        
        expense.itemName = itemName
        expense.itemAmount = NSDecimalNumber(decimal: Decimal(itemAmount))
        expense.expenseCurrency = expenseCurrency
        expense.paymentType = paymentType
        expense.recurringExpense = recurringExpense
        expense.isBudgeted = isBudgeted
        expense.itemQuantity = Double(itemQuantity)
        expense.itemUnit = itemUnit
        expense.payee = payee
        expense.expenseLocation = expenseLocation
        expense.itemDescription = itemDescription
        expense.expenseFrequency = expenseFrequency
        expense.expenseCategory = expenseCategory
        expense.expenseDate = convertToUTC(from: expenseDate)
        let now = Date()
        expense.expenseDate = convertToUTC(from: expenseDate)
        print("Saving expense with date: \(expense.expenseDate?.description ?? "nil")")
        expense.timeEntered = now
        
        try? moc.save()
    }
    
    func convertToUTC(from date: Date) -> Date {
        return date.timeIntervalSince1970.utcDate
    }
}

// make persist expense throwing function

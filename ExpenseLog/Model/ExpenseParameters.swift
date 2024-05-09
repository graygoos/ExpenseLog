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
            self.itemAmount = Double(expense?.viewItemAmount ?? "0") ?? 0.0
            self.itemDescription = expense?.viewItemDescription ?? ""
            self.itemUnit = expense?.itemUnit ?? ""
            self.payee = expense?.viewPayee ?? ""
            self.expenseLocation = expense?.viewExpenseLocation ?? ""
            self.itemQuantity = Int(expense?.viewItemQuantity ?? "0") ?? 0
            self.paymentType = expense?.viewPaymentType ?? ""
            
            if let dateString = expense?.viewExpenseDate, dateString != "N/A" {
                let formatter = DateFormatter()
                formatter.dateFormat = "dd-MM-yyyy" // Ensure this matches the format of the date string
                
                if let date = formatter.date(from: dateString) {
                    self.expenseDate = date
                    print("Parsed Expense Date: \(date)")
                } else {
                    print("Error: Unable to parse date string: \(dateString)")
                    self.expenseDate = Date()
                }
            } else {
                self.expenseDate = Date()
            }
            print("Set Expense Date: \(self.expenseDate)")  // Debug print
        }
    }
    
    init(moc: NSManagedObjectContext? = nil) {
        self.moc = moc
        print("expenseParameters init 🤣 ") // Debug print
    }
    
    var itemName = ""
    var itemAmount: Double = 0.00
    var itemDescription = ""
    var itemUnit = "Non"
    var payee = ""
    var expenseLocation = ""
    var itemQuantity: Int = 1
    var paymentType = "Debit Card"
    var expenseDate = Date()
    var recurringExpense = false
    var isBudgeted = false
    var expenseFrequency = "One-time"
    var expenseCurrency = "NGN"
    var expenseCategory = "Non"
    
    var itemUnits = ["Non", "Pack", "Tin", "Carton", "Bag", "Box", "Bar", "Bottle", "Jar", "Can", "Bowl", "Piece", "Plate", "Case", "Bulk Container", "Pouch", "Blister Pack", "Wrapper", "Foil", "Container", "Envelope", "Cellophane/Plastic wrap", "Bushel", "Pair", "Kilogram", "Roll", "Pound", "Ounce", "Litre", "Centilitre", "Tube", "Bucket", "Sachet", "Cup", "Other"]
    
    var paymentMethod = ["Debit Card", "Cash", "Electronic Funds Transfer", "Credit Card", "Cheque",  "Cryptocurrency", "Bank App"]
    
    var frequency = ["Hourly", "Daily", "Weekly", "Monthly", "Quarterly", "Annually", "One-time"]
    
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
        expense.itemQuantity = Int16(itemQuantity)
        expense.itemUnit = itemUnit
        expense.payee = payee
        expense.expenseLocation = expenseLocation
        expense.itemDescription = itemDescription
        expense.expenseFrequency = expenseFrequency
        expense.expenseDate = expenseDate
        
        try? moc.save()
    }
}


/*
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
            self.itemQuantity = Int(expense?.viewItemQuantity ?? "0")!
            self.paymentType = expense?.viewPaymentType ?? ""
            if let dateString = expense?.viewExpenseDate {
                if dateString == "Expense Date: N/A" {
                    self.expenseDate = Date()
                } else {
                    let formatter = ISO8601DateFormatter()
                    if let date = formatter.date(from: dateString) {
                        self.expenseDate = date
                    } else {
                        // Handle the case where the date string cannot be parsed
                        print("Error: Unable to parse date string: \(dateString)")
                        self.expenseDate = Date()
                    }
                }
            } else {
                self.expenseDate = Date()
            }
        }
    }
    
    init(moc: NSManagedObjectContext? = nil) {
        self.moc = moc
        print("expenseParameters init 🤣 ") // 3
    }
    
    var itemName = ""
    var itemAmount: Double = 0.00
    var itemDescription = ""
    var itemUnit = "Non"
    var payee = ""
    var expenseLocation = ""
    var itemQuantity: Int = 1
    var paymentType = "Debit Card"
    var expenseDate = Date()
    var recurringExpense = false
    var isBudgeted = false
    var expenseFrequency = "One-time"
    var expenseCurrency = "NGN"
    var expenseCategory = "Non"
    
    var itemUnits = ["Non", "Pack", "Tin", "Carton", "Bag", "Box", "Bar", "Bottle", "Jar", "Can", "Bowl", "Piece", "Plate", "Case", "Bulk Container", "Pouch", "Blister Pack", "Wrapper", "Foil", "Container", "Envelope", "Cellophane/Plastic wrap", "Bushel", "Pair", "Kilogram", "Roll", "Pound", "Ounce", "Litre", "Centilitre", "Tube", "Bucket", "Sachet", "Cup", "Other"]
    
    var paymentMethod = ["Debit Card", "Cash", "Electronic Funds Transfer", "Credit Card", "Cheque",  "Cryptocurrency", "Bank App"]
    
    var frequency = ["Hourly", "Daily", "Weekly", "Monthly", "Quarterly", "Annually", "One-time"]
    
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
        expense.itemQuantity = Int16(itemQuantity)
        expense.itemUnit = itemUnit
        expense.payee = payee
        expense.expenseLocation = expenseLocation
        expense.itemDescription = itemDescription
        expense.expenseFrequency = expenseFrequency
        expense.expenseDate = expenseDate
        
        try? moc.save()
    }
}
*/
// make persist expense throwing function

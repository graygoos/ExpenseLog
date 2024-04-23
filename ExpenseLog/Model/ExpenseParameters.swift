//
//  ExpenseParameters.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 21/03/2024.
//

import Foundation
import CoreData

//@Observable
class ExpenseParameters: ObservableObject {
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
                let maybeDate = try? Date(dateString , strategy: .dateTime) //ISO8601 - database/record //fixing date format
                if let maybeDate {
                    self.expenseDate = maybeDate
                } else {
                    self.expenseDate = Date.now
                }
            } else {
                self.expenseDate = Date.now
            }
            
        }
    }
    
    init(moc: NSManagedObjectContext? = nil) {
        self.moc = moc
        print("expenseParameters init 🤣 ") // 3
    }
    
    @Published var itemName = ""
    @Published var itemAmount: Double = 0.00
    @Published var itemDescription = ""
    @Published var itemUnit = "Non"
    @Published var payee = ""
    @Published var expenseLocation = ""
    @Published var itemQuantity: Int = 1
    @Published var paymentType = "Debit Card"
    @Published var expenseDate = Date()
    @Published var recurringExpense = false
    @Published var isBudgeted = false
    @Published var expenseFrequency = "One-time"
    @Published var expenseCurrency = "NGN"
    @Published var expenseCategory = "Non"
    
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
        var expense = self.expense ?? ExpensesEntity(context: moc)
        
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

// make persist expense throwing function

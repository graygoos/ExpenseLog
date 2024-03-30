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
            
//            self.recurringExpense = expense.vie
//            self.isBudgeted = expense
        }
    }
    
    init(moc: NSManagedObjectContext? = nil) {
        self.moc = moc
    }
    
//    init(moc: NSManagedObjectContext? = nil, ) {
//        
//    }
    
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
    
    let allCurrencies: [String] = {
        let locales = Locale.availableIdentifiers.map { Locale(identifier: $0) }
        return locales.compactMap { $0.currency?.identifier }
    }()
    
    var showModal = false
    
    var showPaymentDetailsSection =     false
    var showQuantitySection =           false
    var showVendorSection =             false
    var showLocationSection =           false
    var showDescriptionSection =        false
    var showFrequencySection =          false
    var showCategorySection =           false
    
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

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
    
    init(moc: NSManagedObjectContext? = nil) {
        self.moc = moc
    }
    
//    init(moc: NSManagedObjectContext? = nil, ) {
//        
//    }
    
    var itemName = ""
    var itemAmount = 0.00
    var itemDescription = ""
    var itemUnit = "Non"
    var payee = ""
    var expenseLocation = ""
    var itemQuantity = 1
    var paymentType = "Debit Card"
    var expenseDate = Date()
    var recurringExpense = false
    var isBudgeted = false
    var expenseFrequency = "One-time"
    var expenseCurrency = "NGN"
    
    var itemUnits = ["Non", "Pack", "Tin", "Carton", "Bag", "Box", "Bar", "Bottle", "Jar", "Can", "Bowl", "Piece", "Plate", "Case", "Bulk Container", "Pouch", "Blister Pack", "Wrapper", "Foil", "Container", "Envelope", "Cellophane/Plastic wrap", "Bushel", "Pair", "Kilogram", "Roll", "Pound", "Ounce", "Litre", "Centilitre", "Tube", "Bucket", "Sachet", "Cup", "Other"]
    
    var paymentMethod = ["Debit Card", "Cash", "Electronic Funds Transfer", "Credit Card", "Cheque",  "Cryptocurrency", "Bank App"]
    
    var frequency = ["Hourly", "Daily", "Weekly", "Monthly", "Quarterly", "Annually", "One-time"]
    
    let allCurrencies: [String] = {
        let locales = Locale.availableIdentifiers.map { Locale(identifier: $0) }
        return locales.compactMap { $0.currency?.identifier }
    }()
    
    var showModal = false
    
    var showPaymentDetailsSection =     true
    var showQuantitySection =           true
    var showVendorSection =             true
    var showLocationSection =           true
    var showDescriptionSection =        true
    var showFrequencySection =          true
    
    func persistExpense() {
        guard let moc else {
            return
        }
        let expense = ExpensesEntity(context: moc)
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

//
//  ExpenseEntryView.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 15/11/2023.
//

import SwiftUI

struct ExpenseEntryView: View {
    //    let expense: ExpensesEntity?
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var model = ExpenseParameters()
    
//    @State private var itemName = ""
//    @State private var itemAmount = 0.00
//    @State private var itemDescription = ""
//    @State private var itemUnit = "Non"
//    @State private var payee = ""
//    @State private var expenseLocation = ""
//    @State private var itemQuantity = 1
//    @State private var paymentType = "Debit Card"
//    @State private var expenseDate = Date()
//    @State private var recurringExpense = false
//    @State private var isBudgeted = false
//    @State private var expenseFrequency = "One-time"
//    @State private var expenseCurrency = "NGN"
//    
//    var itemUnits = ["Non", "Pack", "Tin", "Carton", "Bag", "Box", "Bar", "Bottle", "Jar", "Can", "Bowl", "Piece", "Plate", "Case", "Bulk Container", "Pouch", "Blister Pack", "Wrapper", "Foil", "Container", "Envelope", "Cellophane/Plastic wrap", "Bushel", "Pair", "Kilogram", "Roll", "Pound", "Ounce", "Litre", "Centilitre", "Tube", "Bucket", "Sachet", "Cup", "Other"]
//    
//    var paymentMethod = ["Debit Card", "Cash", "Electronic Funds Transfer", "Credit Card", "Cheque",  "Cryptocurrency"]
//    
//    var frequency = ["Hourly", "Daily", "Weekly", "Monthly", "Quarterly", "Annually", "One-time"]
//    
//    let allCurrencies: [String] = {
//        let locales = Locale.availableIdentifiers.map { Locale(identifier: $0) }
//        return locales.compactMap { $0.currency?.identifier }
//    }()
//    
//    @State private var showModal = false
//    
    @State private var showPaymentDetailsSection =     true
//    @State private var showRecurringSection =   true
    @State private var showQuantitySection =    true
    @State private var showVendorSection =      true
    @State private var showLocationSection =    true
    @State private var showDescriptionSection = true
    @State private var showFrequencySection =   true
    @State private var showCategorySection =    true
    
    var body: some View {
        NavigationStack {
                ExpenseFormView(model: $model)
                    .navigationTitle("Enter expense")
                    .onAppear {
                        self.model.moc = moc
                        showPaymentDetailsSection = UserDefaults.standard.bool(forKey: "showPaymentSection")
                    }
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button(action: {
                                print("cancel button tapped")
                                dismiss()
                            }) {
                                Text("Cancel")
                            }
                        }
                        
                        ToolbarItem(placement: .topBarTrailing) {
                            Button(action: {
                                model.persistExpense()
                                dismiss()
                                print("save button tapped")
                            }) {
                                Text("Add")
                            }
                        }
                }
        }
    }
    
//    func persistExpense() {
//        let expense = ExpensesEntity(context: moc)
//        expense.itemName = itemName
//        expense.itemAmount = NSDecimalNumber(decimal: Decimal(itemAmount))
//        expense.expenseCurrency = expenseCurrency
//        expense.paymentType = paymentType
//        expense.recurringExpense = recurringExpense
//        expense.isBudgeted = isBudgeted
//        expense.itemQuantity = Int16(itemQuantity)
//        expense.itemUnit = itemUnit
//        expense.payee = payee
//        expense.expenseLocation = expenseLocation
//        expense.itemDescription = itemDescription
//        expense.expenseFrequency = expenseFrequency
//        expense.expenseDate = expenseDate
//        
//        try? moc.save()
//    }
}

#Preview {
    ExpenseEntryView()
}



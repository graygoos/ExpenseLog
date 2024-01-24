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
    
    @State private var itemName = ""
    @State private var itemAmount = 0.00
    @State private var itemDescription = ""
    @State private var itemUnit = "Non"
    @State private var payee = ""
    @State private var expenseLocation = ""
    @State private var itemQuantity = 1
    @State private var paymentType = "Debit Card"
    @State private var expenseDate = Date()
    @State private var recurringExpense = false
    @State private var isBudgeted = false
    @State private var expenseFrequency = "One-time"
    @State private var expenseCurrency = "NGN"
    
    var itemUnits = ["Non", "Pack", "Tin", "Carton", "Bag", "Box", "Bar", "Bottles", "Jar", "Can", "Bowl", "Piece", "Plate", "Case", "Bulk Container", "Pouch", "Blister Pack", "Wrapper", "Foil", "Container", "Envelope", "Cellophane/Plastic wrap", "Bushel", "Pair", "Other"]
    
    var paymentMethod = ["Debit Card", "Cash", "Electronic Funds Transfer", "Credit Card", "Cheque",  "Cryptocurrency"]
    
    var frequency = ["Hourly", "Daily", "Weekly", "Monthly", "Quarterly", "Annually", "One-time"]
    
    let allCurrencies: [String] = {
        let locales = Locale.availableIdentifiers.map { Locale(identifier: $0) }
        return locales.compactMap { $0.currency?.identifier }
    }()
    
    @State private var showModal = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Item purchased") {
                    TextField("Item name", text: $itemName)
                }
                Section("Enter item amount (Unit Price)") {
                    TextField("Item Amount", value: $itemAmount, format: .currency(code: Locale.current.currency?.identifier ?? "NGN"))
                        .keyboardType(.decimalPad)
                    Picker("Currency", selection: $expenseCurrency) {
                        ForEach(allCurrencies, id: \.self) { unit in
                            Text(unit)
                        }
                    }
                }
                Section {
                    Picker("Payment Method", selection: $paymentType) {
                        ForEach(paymentMethod, id: \.self) { unit in
                            Text(unit)
                        }
                    }
                    Toggle("Recurring expense", isOn: $recurringExpense)
                    Toggle("Budgeted", isOn: $isBudgeted)
                }
                Section("Item quantity") {
                    Stepper("Quantity: \(itemQuantity)", value: $itemQuantity, in: 1...Int.max)
                    Picker("Item Unit", selection: $itemUnit) {
                        ForEach(itemUnits, id: \.self) { unit in
                            Text(unit)
                        }
                    }
                }
                Section("vendor/payee/recipient") {
                    TextField("Vendor", text: $payee)
                }
                Section("location") {
                    VStack {
                        HStack { // V2
                            TextField("Location", text: $expenseLocation)
                            //                        Image(systemName: "mappin.and.ellipse")
                            Button(action: {}) {
                                Image(systemName: "mappin.and.ellipse")
                            }
                        }
                    }
                }
                Section("Item description") {
                    TextField("Description", text: $itemDescription, axis: .vertical)
                        .textFieldStyle(.plain)
                        .lineLimit(5, reservesSpace: true)
                }
                Section {
                    Picker("Expense Frequency", selection: $expenseFrequency) {
                        ForEach(frequency, id: \.self) { item in
                            Text(item)
                        }
                    }
                }
                Section("Expense date") {
                    DatePicker("Date", selection: $expenseDate)
                }
            }
            .navigationTitle("Enter expense")
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
                        persistExpense()
                        dismiss()
                        print("save button tapped")
                    }) {
                        Text("Add")
                    }
                }
            }
        }
    }
    
    func persistExpense() {
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

#Preview {
    ExpenseEntryView()
}



//
//  ExpenseFormView.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 20/03/2024.
//

import SwiftUI

struct ExpenseFormView: View {
    
//    @Environment(\.managedObjectContext) var moc
//    @Environment(\.dismiss) var dismiss
    
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
    
    var itemUnits = ["Non", "Pack", "Tin", "Carton", "Bag", "Box", "Bar", "Bottle", "Jar", "Can", "Bowl", "Piece", "Plate", "Case", "Bulk Container", "Pouch", "Blister Pack", "Wrapper", "Foil", "Container", "Envelope", "Cellophane/Plastic wrap", "Bushel", "Pair", "Kilogram", "Roll", "Pound", "Ounce", "Litre", "Centilitre", "Tube", "Bucket", "Sachet", "Cup", "Other"]
    
    var paymentMethod = ["Debit Card", "Cash", "Electronic Funds Transfer", "Credit Card", "Cheque",  "Cryptocurrency"]
    
    var frequency = ["Hourly", "Daily", "Weekly", "Monthly", "Quarterly", "Annually", "One-time"]
    
    let allCurrencies: [String] = {
        let locales = Locale.availableIdentifiers.map { Locale(identifier: $0) }
        return locales.compactMap { $0.currency?.identifier }
    }()
    
    @State private var showModal = false
    
    @State private var showPaymentDetailsSection =     true
//    @State private var showRecurringSection =   true
    @State private var showQuantitySection =    true
    @State private var showVendorSection =      true
    @State private var showLocationSection =    true
    @State private var showDescriptionSection = true
    @State private var showFrequencySection =   true
    
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
                if showPaymentDetailsSection {
                    Section {
                        Picker("Payment Method", selection: $paymentType) {
                            ForEach(paymentMethod, id: \.self) { unit in
                                Text(unit)
                            }
                        }
                        Toggle("Recurring expense", isOn: $recurringExpense)
                        Toggle("Budgeted", isOn: $isBudgeted)
                    }
                }
                if showQuantitySection {
                    Section("Item quantity") {
                        Stepper("Quantity: \(itemQuantity)", value: $itemQuantity, in: 1...Int.max)
                        Picker("Item Unit", selection: $itemUnit) {
                            ForEach(itemUnits, id: \.self) { unit in
                                Text(unit)
                            }
                        }
                    }
                }
                if showVendorSection {
                    Section("vendor/payee/recipient") {
                        TextField("Vendor", text: $payee)
                    }
                }
                if showLocationSection {
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
                }
                if showDescriptionSection {
                    Section("Item description") {
                        TextField("Description", text: $itemDescription, axis: .vertical)
                            .textFieldStyle(.plain)
                            .lineLimit(5, reservesSpace: true)
                    }
                }
                if showFrequencySection {
                    Section {
                        Picker("Expense Frequency", selection: $expenseFrequency) {
                            ForEach(frequency, id: \.self) { item in
                                Text(item)
                            }
                        }
                    }
                }
                Section("Expense date") {
                    DatePicker("Date", selection: $expenseDate)
                }
            }
        }
    }
}

#Preview {
    ExpenseFormView()
}

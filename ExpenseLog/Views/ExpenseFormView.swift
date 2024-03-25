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
    
    @Binding var model: ExpenseParameters
    
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
//    @State private var showPaymentDetailsSection =     true
////    @State private var showRecurringSection =   true
//    @State private var showQuantitySection =    true
//    @State private var showVendorSection =      true
//    @State private var showLocationSection =    true
//    @State private var showDescriptionSection = true
//    @State private var showFrequencySection =   true
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Item purchased") {
                    TextField("Item name", text: $model.itemName)
                }
                Section("Enter item amount (Unit Price)") {
                    TextField("Item Amount", value: $model.itemAmount, format: .currency(code: Locale.current.currency?.identifier ?? "NGN"))
                        .keyboardType(.decimalPad)
                    Picker("Currency", selection: $model.expenseCurrency) {
                        ForEach(model.allCurrencies, id: \.self) { unit in
                            Text(unit)
                        }
                    }
                }
                if model.showPaymentDetailsSection {
                    Section {
                        Picker("Payment Method", selection: $model.paymentType) {
                            ForEach(model.paymentMethod, id: \.self) { unit in
                                Text(unit)
                            }
                        }
                        Toggle("Recurring expense", isOn: $model.recurringExpense)
                        Toggle("Budgeted", isOn: $model.isBudgeted)
                    }
                }
                if model.showQuantitySection {
                    Section("Item quantity") {
                        Stepper("Quantity: \(model.itemQuantity)", value: $model.itemQuantity, in: 1...Int.max)
//                        StepperWithTextFieldView(itemQty: $model.itemQuantity)
                        Picker("Item Unit", selection: $model.itemUnit) {
                            ForEach(model.itemUnits, id: \.self) { unit in
                                Text(unit)
                            }
                        }
                    }
                }
                if model.showVendorSection {
                    Section("vendor/payee/recipient") {
                        TextField("Vendor", text: $model.payee)
                    }
                }
                if model.showLocationSection {
                    Section("location") {
                        VStack {
                            HStack { // V2
                                TextField("Location", text: $model.expenseLocation)
                                //                        Image(systemName: "mappin.and.ellipse")
                                Button(action: {}) {
                                    Image(systemName: "mappin.and.ellipse")
                                }
                            }
                        }
                    }
                }
                if model.showDescriptionSection {
                    Section("Item description") {
                        TextField("Description", text: $model.itemDescription, axis: .vertical)
                            .textFieldStyle(.plain)
                            .lineLimit(5, reservesSpace: true)
                    }
                }
                if model.showFrequencySection {
                    Section {
                        Picker("Expense Frequency", selection: $model.expenseFrequency) {
                            ForEach(model.frequency, id: \.self) { item in
                                Text(item)
                            }
                        }
                    }
                }
                Section("Expense date") {
                    DatePicker("Date", selection: $model.expenseDate)
                }
            }
        }
    }
}

//#Preview {
//    ExpenseFormView()
//}

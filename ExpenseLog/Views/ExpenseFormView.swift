//
//  ExpenseFormView.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 20/03/2024.
//

import SwiftUI

struct ExpenseFormView: View {
    
    @Environment(\.managedObjectContext) var moc
    @Binding var model: ExpenseParameters
    @Binding var settings: Settings
    @ObservedObject var currencyManager = CurrencyManager()
    
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
                        ForEach(currencyManager.allCurrencies, id: \.self) { unit in
                            Text(unit)
                        }
                    }
                }
                if settings.showPaymentDetailsSection {
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
                if settings.showQuantitySection {
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
                if settings.showVendorSection {
                    Section("vendor/payee/recipient") {
                        TextField("Vendor", text: $model.payee)
                    }
                }
                if settings.showLocationSection {
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
                if settings.showDescriptionSection {
                    Section("Item description") {
                        TextField("Description", text: $model.itemDescription, axis: .vertical)
                            .textFieldStyle(.plain)
                            .lineLimit(5, reservesSpace: true)
                    }
                }
                if settings.showCategorySection {
                    Section("Expense Category") {
                        Picker("Category", selection: $model.expenseCategory) {
                            ForEach(model.category, id: \.self) { category in
                                Text(category)
                            }
                        }
                    }
                }
                if settings.showFrequencySection {
                    Section {
                        Picker("Expense Frequency", selection: $model.expenseFrequency) {
                            ForEach(model.frequency, id: \.self) { item in
                                Text(item ?? "(None)")
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

//
//  Inflection.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 02/07/2024.
//

import Foundation


/*
 struct ExpenseDetailTextView: View {
     var title: String
     var detail: String
     var isCurrency: Bool = false
     var currencyCode: String? = nil
     var symbolName: String? = nil
     var quantity: Int? = nil
     var unit: String? = nil
     
     var body: some View {
         VStack(alignment: .leading) {
             Text(title)
                 .foregroundStyle(.secondary)
                 .frame(idealWidth: .infinity, maxWidth: .infinity, alignment: .leading)
             if isCurrency, let code = currencyCode {
                 Text(Decimal(string: detail) ?? 0, format: .currency(code: code))
             } else if let quantity = quantity, let unit = unit {
                 Text("^[\(quantity) \(unit)](inflect: true)")
             } else {
                 Text(detail)
             }
         }
     }
 }

 
 
 import SwiftUI

 struct ExpenseDetailsView: View {
     @Environment(\.managedObjectContext) var moc
     @Environment(\.dismiss) var dismiss
     var expense: ExpensesEntity
     
     @Binding var model: ExpenseParameters
     
     @State private var showModal = false
     
     @Binding var settings: Settings
     
     var body: some View {
         ScrollView {
             VStack(alignment: .leading) {
                 ExpenseDetailTextView(title: "Date", detail: expense.viewExpenseDate)
                 ExpenseDetailTextView(title: "Item name", detail: expense.viewItemName)
                 ExpenseDetailTextView(title: "Amount", detail: expense.viewItemAmount, isCurrency: true, currencyCode: expense.expenseCurrency)
                 
                 if settings.showPaymentDetailsSection || !expense.viewPaymentType.isEmpty || expense.recurringExpense || expense.isBudgeted {
                     ExpenseDetailTextView(title: "Payment Method", detail: expense.viewPaymentType.isEmpty ? "nil" : expense.viewPaymentType)
                     ExpenseDetailTextView(title: "Recurring Expense", detail: expense.recurringExpense ? "Yes" : "No")
                     ExpenseDetailTextView(title: "Budgeted", detail: expense.isBudgeted ? "Yes" : "No")
                 }
                 
                 if settings.showQuantitySection || (expense.viewItemQuantity > "0" && expense.itemUnit != nil) {
                     if let quantity = Int(expense.viewItemQuantity), let unit = expense.viewItemUnit {
                         ExpenseDetailTextView(title: "Quantity", detail: "\(quantity)", quantity: quantity, unit: unit)
                     } else {
                         ExpenseDetailTextView(title: "Quantity", detail: expense.viewItemQuantity)
                         ExpenseDetailTextView(title: "Unit", detail: expense.viewItemUnit ?? "None")
                     }
                 }
                 
                 if settings.showVendorSection || !expense.viewPayee.isEmpty {
                     ExpenseDetailTextView(title: "Vendor", detail: expense.viewPayee.isEmpty ? "nil" : expense.viewPayee)
                 }
                 
                 if settings.showLocationSection || !expense.viewExpenseLocation.isEmpty {
                     ExpenseDetailTextView(title: "Location", detail: expense.viewExpenseLocation.isEmpty ? "nil" : expense.viewExpenseLocation)
                 }
                 
                 if settings.showDescriptionSection || !expense.viewItemDescription.isEmpty {
                     ExpenseDetailTextView(title: "Description", detail: expense.viewItemDescription.isEmpty ? "nil" : expense.viewItemDescription)
                 }
                 
                 ExpenseDetailTextView(title: "Category", detail: expense.expenseCategory ?? "Non", symbolName: SFSymbolManager.symbolForCategory(expense.expenseCategory ?? "Non"))
                 ExpenseDetailTextView(title: "Frequency", detail: "Non set")
             }
             .navigationTitle("Expense Details")
             .navigationBarTitleDisplayMode(.inline)
             .toolbar(.hidden, for: .tabBar)
             .padding()
             .toolbar {
                 ToolbarItem {
                     Button(action: {
                         self.showModal.toggle()
                     }) {
                         Text("Edit")
                     }
                     .sheet(isPresented: $showModal, onDismiss: {
                         
                     }, content: {
                         ExpenseEditScreen(expense: expense, model: $model, settings: $settings)
                     })
                 }
             }
             Button(action: {
                 deleteExpense()
                 dismiss()
             }) {
                 Text("Delete Entry")
             }
             .onAppear {
                 self.model.expense = self.expense
                 self.model.moc = self.moc
             }
         }
     }
     
     private func deleteExpense() {
         moc.delete(expense)
         try? moc.save()
     }
 }

 
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
                         Picker("Item Unit", selection: $model.itemUnit) {
                             ForEach(model.itemUnits, id: \.self) { unit in
                                 Text("^[\(model.itemQuantity) \(unit)](inflect: true)")
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

 */

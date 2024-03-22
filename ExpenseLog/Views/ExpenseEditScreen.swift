//
//  ExpenseEditScreen.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 20/03/2024.
//

import SwiftUI

struct ExpenseEditScreen: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var model = ExpenseParameters()
    
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
    
    var body: some View {
        NavigationStack {
            ExpenseFormView(model: $model)
                .navigationTitle("Edit Expense")
                .navigationBarTitleDisplayMode(.inline)
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
//                            persistExpense()
                            dismiss()
                            print("save button tapped")
                        }) {
                            Text("Save")
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
    ExpenseEditScreen()
}

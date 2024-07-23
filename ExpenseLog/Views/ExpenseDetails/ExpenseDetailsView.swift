//
//  ExpenseDetailsView.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 15/02/2024.
//

import SwiftUI

struct ExpenseDetailsView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    var expense: ExpensesEntity
    
    @Binding var model: ExpenseParameters
    
    @State private var showModal = false
    
    @Binding var settings: Settings
    
    @State private var showingDeleteAlert = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                // this shows when the user entered the expense
                ExpenseDetailTextView(title: "Date", detail: expense.expenseDate?.localizedStringWithTime ?? "Unknown Date")
                // this shows when entry was made or last edited
                // ExpenseDetailTextView(title: "Entered", detail: expense.timeEntered?.localizedStringWithTime ?? "Unknown Date")
                ExpenseDetailTextView(title: "Item name", detail: expense.viewItemName)
                ExpenseDetailTextView(
                    title: "Amount",
                    detail: formatAmount(amount: (expense.itemAmount ?? 0) as Decimal, currencyCode: expense.expenseCurrency ?? "USD")
                )
                
                if settings.showPaymentDetailsSection || !expense.viewPaymentType.isEmpty || expense.recurringExpense || expense.isBudgeted {
                    ExpenseDetailTextView(title: "Payment Method", detail: expense.viewPaymentType.isEmpty ? "nil" : expense.viewPaymentType)
                    ExpenseDetailTextView(title: "Recurring Expense", detail: expense.recurringExpense ? "Yes" : "No")
                    ExpenseDetailTextView(title: "Budgeted", detail: expense.isBudgeted ? "Yes" : "No")
                }
                
                if settings.showQuantitySection || (expense.viewItemQuantity > String(0) && expense.itemUnit != nil) {
                    if let quantity = Double(expense.viewItemQuantity), let unit = expense.itemUnit {
                        ExpenseDetailTextView(title: "Quantity", detail: "\(quantity)", quantity: quantity, unit: unit)
                    } else {
                        ExpenseDetailTextView(title: "Quantity", detail: expense.viewItemQuantity)
                        ExpenseDetailTextView(title: "Unit", detail: expense.itemUnit ?? "None")
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
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button(role: .destructive, action: {
                        showingDeleteAlert = true
                    }) {
                        Image(systemName: "trash")
                        Text("Delete Entry")
                    }
                    .onAppear {
                        self.model.expense = self.expense
                        self.model.moc = self.moc
                    }
                }
            }
        }
        .alert("Delete Expense", isPresented: $showingDeleteAlert) {
            Button("Cancel", role: .cancel) {}
            Button("Delete", role: .destructive) {
                deleteExpense()
                dismiss()
            }
        } message: {
            Text("Are you sure you want to delete this expense?")
        }
    }
    
    private func deleteExpense() {
        moc.delete(expense)
        try? moc.save()
    }
    
    private func formatAmount(amount: Decimal, currencyCode: String) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currencyCode
        
        let formattedAmount = formatter.string(from: amount as NSNumber) ?? ""
        
        return "\(formattedAmount) (\(currencyCode))"
    }
}



#Preview {
    @Environment(\.managedObjectContext) var moc
    // Create default instances for model and settings
    @State var model = ExpenseParameters(expenseDate: Date())
    @State var settings = Settings(moc: moc)

    // Create a mock expense
    let expense = ExpensesEntity()

    return ExpenseDetailsView(expense: expense, model: $model, settings: $settings)
        .environment(\.managedObjectContext, ExpenseLogContainer(forPreview: true).persistentContainer.viewContext)
}


extension ExpensesEntity {
    var localizedExpenseDate: String {
        return expenseDate?.localizedStringWithTime ?? "Unknown Date"
    }
    var localizedTimeEntered: String {
        return timeEntered?.localizedStringWithTime ?? "Unknown Date"
    }
}

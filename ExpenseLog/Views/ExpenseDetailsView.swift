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

    var body: some View {
        VStack(alignment: .leading) {
            TodayExpenseSectionHeader()
            Divider()
            
            HStack {
                Text(expense.viewItemName)
                Spacer()
                Text(Decimal(string: expense.viewItemAmount) ?? 0, format: .currency(code: expense.expenseCurrency ?? "NGN"))
            }
            Divider()
            
            if settings.showDescriptionSection || !expense.viewItemDescription.isEmpty {
                Text("Description")
                Text(expense.viewItemDescription)
                Divider()
            }
            
            if settings.showLocationSection || !expense.viewExpenseLocation.isEmpty {
                Text("Location")
                Text(expense.viewExpenseLocation)
                Divider()
            }
            
            if settings.showQuantitySection || (expense.viewItemQuantity > String(0) && expense.itemUnit != nil) {
                Text("Quantity")
                Text("\(expense.viewItemQuantity) \(expense.itemUnit ?? "")")
                Divider()
            }
            
            if settings.showVendorSection || !expense.viewPayee.isEmpty {
                Text("Vendor")
                Text(expense.viewPayee)
                Divider()
            }
            
            if settings.showPaymentDetailsSection || !expense.viewPaymentType.isEmpty || expense.recurringExpense || expense.isBudgeted {
                Text("Payment Method")
                Text(expense.viewPaymentType)
                Divider()
                
                Text("Recurring Expense")
                Text(expense.recurringExpense ? "Yes" : "No")
                Divider()
                
                Text("Budgeted")
                Text(expense.isBudgeted ? "Yes" : "No")
                Divider()
            }
            
            if settings.showCategorySection || ((expense.expenseCategory?.isEmpty) == nil) {
                Text("Category")
                Text(expense.expenseCategory ?? "Non")
                Divider()
            }
            
            if settings.showFrequencySection || ((expense.expenseFrequency?.isEmpty) == nil) {
                Text("Frequency")
                Text(expense.expenseFrequency ?? "One-time")
                Divider()
            }
            
            Spacer()
            VStack(alignment: .center) {
                Button(action: {
                    deleteExpense()
                    dismiss()
                }) {
                    Text("Delete Entry")
                }
            }
            Spacer()
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
        .onAppear {
            self.model.expense = self.expense
            self.model.moc = self.moc
        }
    }

    private func deleteExpense() {
        moc.delete(expense)
        try? moc.save()
    }
}


#Preview {
    @Environment(\.managedObjectContext) var moc
    // Create default instances for model and settings
    @State var model = ExpenseParameters()
    @State var settings = Settings(moc: moc)

    // Create a mock expense
    let expense = ExpensesEntity()

    return ExpenseDetailsView(expense: expense, model: $model, settings: $settings)
        .environment(\.managedObjectContext, ExpenseLogContainer(forPreview: true).persistentContainer.viewContext)
}


//#Preview {
//    ExpenseDetailsView(expenses: ExpensesEntity())
//        .environment(\.managedObjectContext, ExpenseLogContainer(forPreview: true).persistentContainer.viewContext)
//}


/*
 import SwiftUI

 struct ExpenseDetailsView: View {
     @Environment(\.managedObjectContext) var moc
     @Environment(\.dismiss) var dismiss
     var expense: ExpensesEntity
     
 //    @State private var model = ExpenseParameters()
     @Binding var model: ExpenseParameters
     
     @State private var showModal = false
     
     @Binding var settings: Settings
     
     var body: some View {
             VStack {
                 TodayExpenseSectionHeader()
                 HStack {
                     Text(expense.viewItemName)
                     Spacer()
                     Text(Decimal(string: expense.viewItemAmount) ?? 0, format: .currency(code: expense.expenseCurrency ?? "NGN"))
                 }
                 
                 Text(expense.viewItemDescription)
                 Text(expense.viewExpenseLocation)
                 
                 Spacer()
                 
                 Button(action: {
                     deleteExpense()
                     dismiss()
                 }) {
                     Text("Delete Entry")
                 }
                 
                 Spacer()
                 Spacer()
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
 //                        print("expenseEntryView dismissed")
                     }, content: {
                         ExpenseEditScreen(expense: expense, model: $model, settings: $settings)
                     })
                 }
             }
         .onAppear {
             self.model.expense = self.expense
             self.model.moc = self.moc
         }
     }
     
     private func deleteExpense() {
         moc.delete(expense)
         
         try? moc.save()
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
         VStack(alignment: .leading) {
             TodayExpenseSectionHeader()
             Divider()
             
             HStack {
                 Text(expense.viewItemName)
                 Spacer()
                 Text(Decimal(string: expense.viewItemAmount) ?? 0, format: .currency(code: expense.expenseCurrency ?? "NGN"))
             }
             Divider()
             
             if settings.showDescriptionSection || !expense.viewItemDescription.isEmpty {
                 Text("Description")
                 Text(expense.viewItemDescription)
                 Divider()
             }
             
             if settings.showLocationSection || !expense.viewExpenseLocation.isEmpty {
                 Text("Location")
                 Text(expense.viewExpenseLocation)
                 Divider()
             }
             
             if settings.showQuantitySection || (expense.viewItemQuantity > String(0) && expense.itemUnit != nil) {
                 Text("Quantity")
                 Text("\(expense.viewItemQuantity) \(expense.itemUnit ?? "")")
                 Divider()
             }
             
             if settings.showVendorSection || !expense.viewPayee.isEmpty {
                 Text("Vendor")
                 Text(expense.viewPayee)
                 Divider()
             }
             
             if settings.showPaymentDetailsSection || !expense.viewPaymentType.isEmpty || expense.recurringExpense || expense.isBudgeted {
                 Text("Payment Method")
                 Text(expense.viewPaymentType)
                 Divider()
                 
                 Text("Recurring Expense")
                 Text(expense.recurringExpense ? "Yes" : "No")
                 Divider()
                 
                 Text("Budgeted")
                 Text(expense.isBudgeted ? "Yes" : "No")
                 Divider()
             }
             
             if settings.showCategorySection || ((expense.expenseCategory?.isEmpty) == nil) {
                 Text("Category")
                 Text(expense.expenseCategory ?? "Non")
                 Divider()
             }
             
             if settings.showFrequencySection || ((expense.expenseFrequency?.isEmpty) == nil) {
                 Text("Frequency")
                 Text(expense.expenseFrequency ?? "One-time")
                 Divider()
             }
             
             Spacer()
             VStack(alignment: .center) {
                 Button(action: {
                     deleteExpense()
                     dismiss()
                 }) {
                     Text("Delete Entry")
                 }
             }
             Spacer()
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
         .onAppear {
             self.model.expense = self.expense
             self.model.moc = self.moc
         }
     }

     private func deleteExpense() {
         moc.delete(expense)
         try? moc.save()
     }
 }
 */

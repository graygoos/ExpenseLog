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
    
    @State private var model = ExpenseParameters()
    
    @State private var showModal = false
    
//    @Binding var settings: Settings
    
    var body: some View {
//        NavigationStack {
            VStack {
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
            .padding()
//            .toolbar {
//                ToolbarItem {
//                    Button(action: {
//                        self.showModal.toggle()
//                    }) {
//                        Text("Edit")
//                    }
//                    .sheet(isPresented: $showModal, onDismiss: {
////                        print("expenseEntryView dismissed")
//                    }, content: {
//                        ExpenseEditScreen(expense: expense, model: $model, settings: $settings)
//                    })
//                }
//            }
//        }
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

//#Preview {
//    ExpenseDetailsView(expenses: ExpensesEntity())
//        .environment(\.managedObjectContext, ExpenseLogContainer(forPreview: true).persistentContainer.viewContext)
//}

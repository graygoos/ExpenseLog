//
//  ExpenseDetailsView.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 15/02/2024.
//

import SwiftUI

struct ExpenseDetailsView: View {
    @Environment(\.managedObjectContext) var moc
    var expenses: ExpensesEntity
    
    @State private var model = ExpenseParameters()
    
    @State private var showModal = false
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text(expenses.viewItemName)
                    Spacer()
                    Text(Decimal(string: expenses.viewItemAmount) ?? 0, format: .currency(code: expenses.expenseCurrency ?? "NGN"))
                }
                
                Text(expenses.viewItemDescription)
                Text(expenses.viewExpenseLocation)
                
                Spacer()
                
                Button(action: {
                    deleteExpense()
                }) {
                    Text("Delete Entry")
                }
                
                Spacer()
                Spacer()
            }
            .navigationTitle("Expense Details")
            .navigationBarTitleDisplayMode(.inline)
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
                        ExpenseEditScreen(expense: expenses, model: $model)
                    })
                }
            }
        }
    }
    
    private func deleteExpense() {
        moc.delete(expenses)
        
        try? moc.save()
        
//        path.removeAll()
    }
}

//#Preview {
//    ExpenseDetailsView(expenses: ExpensesEntity())
//        .environment(\.managedObjectContext, ExpenseLogContainer(forPreview: true).persistentContainer.viewContext)
//}

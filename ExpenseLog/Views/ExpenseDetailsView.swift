//
//  ExpenseDetailsView.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 15/02/2024.
//

import SwiftUI

struct ExpenseDetailsView: View {
    var expenses: ExpensesEntity
    
    var body: some View {
        VStack {
            HStack {
                Text(expenses.viewItemName)
                Spacer()
    //            Text(((expenses.viewItemAmount)) as Decimal, format: .currency(code: expenses.expenseCurrency ?? "NGN"))
                Text(Decimal(string: expenses.viewItemAmount) ?? 0, format: .currency(code: expenses.expenseCurrency ?? "NGN"))
            }
            
            Text(expenses.viewItemDescription)
            Text(expenses.viewExpenseLocation)
        }
        .padding()
    }
}

#Preview {
    ExpenseDetailsView(expenses: ExpensesEntity())
        .environment(\.managedObjectContext, ExpenseLogContainer(forPreview: true).persistentContainer.viewContext)
}

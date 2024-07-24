//
//  ExpenseRowView.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 24/07/2024.
//

import SwiftUI

struct ExpenseRowView: View {
    let expense: ExpensesEntity
    
    var body: some View {
        HStack {
            Image(systemName: SFSymbolManager.symbolForPaymentType(expense.paymentType ?? ""))
                .foregroundStyle(.gray)
            VStack(alignment: .leading) {
                Text("\(expense.viewItemName)")
                    .font(.title3)
                    .truncationMode(.tail)
                    .lineLimit(1)
                if expense.viewItemDescription.isEmpty {
                    Text(expense.viewFormattedExpenseDate)
                        .font(.footnote)
                        .foregroundStyle(.gray)
                        .truncationMode(.tail)
                } else {
                    Text(expense.viewItemDescription)
                        .font(.footnote)
                        .foregroundStyle(.gray)
                        .truncationMode(.tail)
                        .lineLimit(1)
                }
            }
            Spacer()
            Text(((expense.itemAmount))! as Decimal, format: .currency(code: expense.expenseCurrency ?? "NGN"))
        }
    }
}

//#Preview {
//    ExpenseRowView()
//}

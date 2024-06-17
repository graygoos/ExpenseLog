//
//  TodayExpenseSectionFooter.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 11/12/2023.
//

import SwiftUI

struct TodayExpenseSectionFooter: View {
    
    var expenses: FetchedResults<ExpensesEntity>
    
    private func totalsByCurrency() -> [String: Decimal] {
        var totals: [String: Decimal] = [:]
        
        for expense in expenses {
            let currency = expense.expenseCurrency ?? "NGN"
            let amount = expense.itemAmount! as Decimal
            totals[currency, default: 0] += amount
        }
        
        return totals
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Total")
                .font(.bold(.title2)())
            
            ForEach(totalsByCurrency().sorted(by: { $0.key < $1.key }), id: \.key) { currency, total in
                HStack {
                    Spacer()
                    Text("\(total, format: .currency(code: currency))")
                        .font(.bold(.title2)())
                }
            }
        }
    }
}

#Preview {
    @FetchRequest<ExpensesEntity>(
        sortDescriptors: [],
            predicate: NSPredicate(format: "%K >= %@ AND %K <= %@", argumentArray: [#keyPath(ExpensesEntity.expenseDate), Date().startOfDay as NSDate, #keyPath(ExpensesEntity.expenseDate), Date().endDayOf as NSDate]),
            animation: .default
        ) var expenses
    
    return TodayExpenseSectionFooter(expenses: expenses)
}

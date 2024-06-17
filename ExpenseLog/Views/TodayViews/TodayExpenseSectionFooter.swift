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
        let primaryCurrency = Locale.current.currency?.identifier ?? "NGN"
        let sortedTotals = totalsByCurrency().sorted { (lhs, rhs) in
            if lhs.key == primaryCurrency {
                return true
            } else if rhs.key == primaryCurrency {
                return false
            } else {
                return lhs.key < rhs.key
            }
        }
        
        VStack(alignment: .leading) {
            HStack {
                Text("Total")
                    .font(.bold(.title2)())
                Spacer()
                VStack(alignment: .trailing) {
                    ForEach(sortedTotals, id: \.key) { currency, total in
                        HStack {
                            Spacer()
                            Text("\(total, format: .currency(code: currency))")
                                .font(currency == primaryCurrency ? .bold(.title2)() : .headline)
                        }
                    }
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

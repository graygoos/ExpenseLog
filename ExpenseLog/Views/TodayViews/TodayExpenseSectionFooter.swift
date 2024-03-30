//
//  TodayExpenseSectionFooter.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 11/12/2023.
//

import SwiftUI

struct TodayExpenseSectionFooter: View {
    
    var expenses: FetchedResults<ExpensesEntity>
    
//    @Binding var total: Decimal
    
    var dailyTotal: Decimal {
        expenses.reduce(0) { result, expense in
            expense.itemAmount! as Decimal + result
        }
//        return 0
    }
    
    var body: some View {
        HStack {
            Text("Total")
                .font(.bold(.title2)())
            Spacer()
            Text("\(dailyTotal, format: .currency(code: Locale.current.currency?.identifier ?? "NGN"))")
                .font(.bold(.title2)())
            // Text(((expense.itemAmount))! as Decimal, format: .currency(code: expense.expenseCurrency ?? "NGN"))
        }
        /*
        VStack(alignment: .trailing) {
            ForEach(Array(Set(expenses.compactMap { $0.expenseCurrency })), id: \.self) { currency in
                if let currency = currency {
                    Text("\(currency): \(totalForCurrency(currency: currency), format: .currency(code: currency))")
                        .font(.bold(.title2)())
                }
            }
        }
         */
    }
    /*
    // Function to calculate the total for each currency
    func totalForCurrency(currency: String) -> Decimal {
        expenses.reduce(Decimal(0)) { result, expense in
            if expense.expenseCurrency == currency {
                return (expense.itemAmount! as Decimal) + result
            } else {
                return result
            }
        }
    }
     */
}

#Preview {
//    let moc = ExpenseLogContainer(forPreview: true).persistentContainer.viewContext
    
    @FetchRequest<ExpensesEntity>(
        sortDescriptors: [],
            predicate: NSPredicate(format: "%K >= %@ AND %K <= %@", argumentArray: [#keyPath(ExpensesEntity.expenseDate), Date().startOfDay as NSDate, #keyPath(ExpensesEntity.expenseDate), Date().endDayOf as NSDate]),
            animation: .default
        ) var expenses
    
    return TodayExpenseSectionFooter(expenses: expenses)
}

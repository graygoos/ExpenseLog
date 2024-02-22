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
        }
    }
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

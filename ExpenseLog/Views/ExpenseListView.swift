//
//  ExpenseListView.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 05/02/2024.
//


import SwiftUI

struct ExpenseListView: View {
    let date: Date
    
    @FetchRequest var expenses: FetchedResults<ExpensesEntity>
    
    init(date: Date) {
        self.date = date
        let predicate = NSPredicate(format: "expenseDate >= %@ AND expenseDate < %@", argumentArray: [date, Calendar.current.date(byAdding: .day, value: 1, to: date)!])
        _expenses = FetchRequest(entity: ExpensesEntity.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \ExpensesEntity.expenseDate, ascending: false)], predicate: predicate, animation: .default)
    }

    var body: some View {
        VStack {

            List {
                ForEach(expenses, id: \.self) { expense in
                    HStack {
                        Text("\(expense.viewItemName)")
                            .truncationMode(.tail)
                            .lineLimit(1)
                        Spacer()
                        Text(((expense.itemAmount))! as Decimal, format: .currency(code: expense.expenseCurrency ?? "NGN"))
                    }
                }
                TodayExpenseSectionFooter(expenses: expenses)
            }
            .navigationTitle("Expenses for \(date.formattedDay)")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


#Preview {
    ExpenseListView(date: Date())
}


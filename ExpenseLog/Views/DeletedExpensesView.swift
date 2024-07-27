//
//  DeletedExpensesView.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 26/07/2024.
//

import SwiftUI
import CoreData

struct DeletedExpensesView: View {
    @Environment(\.managedObjectContext) private var moc
    @FetchRequest(
        entity: ExpensesEntity.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \ExpensesEntity.expenseDate, ascending: false)],
        predicate: NSPredicate(format: "isExpenseDeleted == %@", NSNumber(value: true))
    ) private var deletedExpenses: FetchedResults<ExpensesEntity>
    
    var body: some View {
        List {
            ForEach(deletedExpenses) { expense in
                ExpenseRow(expense: expense)
                    .swipeActions {
                        Button("Restore") {
                            restoreExpense(expense)
                        }
                        .tint(.green)
                    }
            }
        }
        .navigationTitle("Deleted Expenses")
        .overlay(Group {
            if deletedExpenses.isEmpty {
                Text("No deleted expenses")
                    .foregroundColor(.secondary)
            }
        })
    }
    
    private func restoreExpense(_ expense: ExpensesEntity) {
        expense.isExpenseDeleted = false
        do {
            try moc.save()
        } catch {
            print("Failed to restore expense: \(error)")
        }
    }
}

struct ExpenseRow: View {
    let expense: ExpensesEntity
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(expense.itemName ?? "Unknown")
                .font(.headline)
            Text(expense.expenseDate?.formatted(date: .abbreviated, time: .omitted) ?? "Unknown date")
                .font(.subheadline)
            Text(formattedAmount)
                .font(.subheadline)
        }
    }
    
    private var formattedAmount: String {
        let amount = expense.itemAmount?.doubleValue ?? 0
        let currency = expense.expenseCurrency ?? ""
        return String(format: "%@ %.2f", currency, amount)
    }
}

#Preview {
    DeletedExpensesView()
}

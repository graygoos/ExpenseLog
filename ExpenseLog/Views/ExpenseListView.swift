//
//  ExpenseListView.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 05/02/2024.
//


import SwiftUI

struct ExpenseListView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    let date: Date
    
    @Binding var settings: Settings
    @State private var model = ExpenseParameters()

    
    @FetchRequest var expenses: FetchedResults<ExpensesEntity>
    
    init(date: Date, settings: Binding<Settings>) {
        self.date = date
        self._settings = settings
        let predicate = NSPredicate(format: "expenseDate >= %@ AND expenseDate < %@", argumentArray: [date, Calendar.current.date(byAdding: .day, value: 1, to: date)!])
        _expenses = FetchRequest(entity: ExpensesEntity.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \ExpensesEntity.expenseDate, ascending: false)], predicate: predicate, animation: .default)
    }

    var body: some View {
        VStack {
            List {
                ForEach(expenses, id: \.self) { expense in
                    NavigationLink {
                        ExpenseDetailsView(expense: expense, model: $model, settings: $settings)
                    } label: {
                        HStack {
                            Text("\(expense.viewItemName)")
                                .truncationMode(.tail)
                                .lineLimit(1)
                            Spacer()
                            Text(((expense.itemAmount))! as Decimal, format: .currency(code: expense.expenseCurrency ?? "NGN"))
                        }
                    }
                }
                .onDelete(perform: deleteExpense)
                TodayExpenseSectionFooter(expenses: expenses)
            }
            .navigationTitle("Expenses for \(date.formattedDay)")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(.hidden, for: .tabBar)
        }
    }
    
    private func deleteExpense(offsets: IndexSet) {
        for offset in offsets {
            moc.delete(expenses[offset])
        }
        try? moc.save()
        dismiss()
    }
}


#Preview {
    @Environment(\.managedObjectContext) var moc
    @State var settings = Settings(moc: moc)
    return ExpenseListView(date: Date(), settings: $settings)
}


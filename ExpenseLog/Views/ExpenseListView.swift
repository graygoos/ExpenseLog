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
    @State private var model = ExpenseParameters(expenseDate: Date())
    
    @State private var showingDeleteAlert = false
    @State private var expenseToDelete: ExpensesEntity?
    @State private var showingExpenseEntryView = false
    let isPresentedModally: Bool
    
    @FetchRequest var expenses: FetchedResults<ExpensesEntity>
    
    init(date: Date, settings: Binding<Settings>, isPresentedModally: Bool = false) {
        self.date = date
        self._settings = settings
        self.isPresentedModally = isPresentedModally
        
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        let predicate = NSPredicate(format: "expenseDate >= %@ AND expenseDate < %@", startOfDay as NSDate, endOfDay as NSDate)
        _expenses = FetchRequest(entity: ExpensesEntity.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \ExpensesEntity.expenseDate, ascending: true)], predicate: predicate, animation: .default)
    }
    
    var body: some View {
        NavigationStack {
            Group {
                if expenses.isEmpty {
                    VStack {
                        Spacer()
                        Text("No expenses for \(date.formatted(date: .long, time: .omitted))")
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                } else {
                    List {
                        ForEach(expenses, id: \.self) { expense in
                            NavigationLink {
                                ExpenseDetailsView(expense: expense, model: $model, settings: $settings)
                            } label: {
                                ExpenseRowView(expense: expense)
                            }
                        }
                        .onDelete { indexSet in
                            guard let index = indexSet.first else { return }
                            expenseToDelete = expenses[index]
                            showingDeleteAlert = true
                        }
                        TodayExpenseSectionFooter(expenses: expenses)
                    }
                }
            }
            .navigationTitle("Expenses for \(date.formatted(date: .long, time: .omitted))")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if isPresentedModally {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Done") {
                            dismiss()
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingExpenseEntryView = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .sheet(isPresented: $showingExpenseEntryView) {
            ExpenseEntryView(settings: $settings, initialDate: date)
        }
        .alert("Delete Expense", isPresented: $showingDeleteAlert) {
            Button("Cancel", role: .cancel) {}
            Button("Delete", role: .destructive) {
                if let expense = expenseToDelete {
                    deleteExpense(expense: expense)
                }
            }
        } message: {
            Text("Are you sure you want to delete this expense?")
        }
    }
    
    private func deleteExpense(expense: ExpensesEntity) {
        moc.delete(expense)
        try? moc.save()
        if expenses.isEmpty {
            dismiss()
        }
    }
}

#Preview {
    @Environment(\.managedObjectContext) var moc
    @State var settings = Settings(moc: moc)
    return ExpenseListView(date: Date(), settings: $settings)
}


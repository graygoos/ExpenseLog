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
                            Image(systemName: symbolForPaymentType(expense.paymentType ?? ""))
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
                .onDelete { indexSet in
                    guard let index = indexSet.first else { return }
                    expenseToDelete = expenses[index]
                    showingDeleteAlert = true
                }
                TodayExpenseSectionFooter(expenses: expenses)
            }
            .navigationTitle("Expenses for \(date.formattedDay)")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(.hidden, for: .tabBar)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        showingExpenseEntryView = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingExpenseEntryView) {
                ExpenseEntryView(settings: $settings, initialDate: date)
            }
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
    
    private func symbolForPaymentType(_ paymentType: String) -> String {
            switch paymentType {
            case "Debit Card":
                return "creditcard.fill"
            case "Cash":
                return "banknote.fill"
            case "Electronic Funds Transfer":
                return "arrow.right.arrow.left.circle.fill"
            case "Credit Card":
                return "creditcard.fill"
            case "Cheque":
                return "checkmark.rectangle.fill"
            case "Cryptocurrency":
                return "bitcoinsign.circle.fill"
            case "Bank App":
                return "iphone.homebutton"
            case "USSD":
                return "number"
            default:
                return "creditcard.fill"
            }
        }
}


#Preview {
    @Environment(\.managedObjectContext) var moc
    @State var settings = Settings(moc: moc)
    return ExpenseListView(date: Date(), settings: $settings)
}


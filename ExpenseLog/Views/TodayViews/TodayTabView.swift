//
//  TodayTabView.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 17/10/2023.

import SwiftUI

struct TodayTabView: View {
    @Environment(\.managedObjectContext) var moc
    
    @Binding var settings: Settings
    @State private var model = ExpenseParameters(expenseDate: Date())
    
    @State private var showingDeleteAlert = false
    @State private var expenseToDelete: ExpensesEntity?
    
    @State private var currentDateForFetch = Date()
    
    @FetchRequest private var expenses: FetchedResults<ExpensesEntity>
    
    @State private var newExpense = false
    @State private var showModal = false
    
    init(settings: Binding<Settings>) {
        self._settings = settings
        self._expenses = FetchRequest<ExpensesEntity>(
            sortDescriptors: [],
            predicate: NSPredicate(format: "%K >= %@ AND %K <= %@",
                                   argumentArray: [#keyPath(ExpensesEntity.expenseDate),
                                                   Date().startOfDay as NSDate,
                                                   #keyPath(ExpensesEntity.expenseDate),
                                                   Date().endDayOf as NSDate]),
            animation: .default
        )
    }
    
    var currentDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyy"
        return dateFormatter.string(from: currentDateForFetch)
    }
    
    var body: some View {
        NavigationStack {
            if !expenses.isEmpty {
                List {
                    Section(header: TodayExpenseSectionHeader(), footer: TodayExpenseSectionFooter(expenses: expenses)) {
                        ForEach(expenses) { expense in
                            NavigationLink {
                                ExpenseDetailsView(expense: expense, model: $model, settings: $settings)
                            } label: {
                                HStack {
                                    Image(systemName: SFSymbolManager.symbolForPaymentType(expense.paymentType ?? ""))
                                        .foregroundStyle(.accent)
                                    VStack(alignment: .leading) {
                                        Text(expense.viewItemName)
                                            .truncationMode(.tail)
                                            .lineLimit(1)
                                        Text(expense.timeEnteredFormatted)
                                            .font(.footnote)
                                            .foregroundStyle(.gray)
                                    }
                                    Spacer()
                                    Text((expense.itemAmount ?? 0) as Decimal, format: .currency(code: expense.expenseCurrency ?? "NGN"))
                                }
                            }
                        }
                        .onDelete { indexSet in
                            guard let index = indexSet.first else { return }
                            expenseToDelete = expenses[index]
                            showingDeleteAlert = true
                        }
                    }
                }
                .navigationTitle(Text(currentDate))
                .listStyle(.plain)
                .toolbar {
                    ToolbarItem {
                        Button(action: {
                            self.showModal.toggle()
                        }) {
                            Image(systemName: "plus")
                                .imageScale(.large)
                        }
                        .sheet(isPresented: $showModal, onDismiss: {
                            print("expenseEntryView dismissed")
                        }, content: {
                            ExpenseEntryView(settings: $settings)
                        })
                    }
                }
            } else {
                TodayEmptyView(settings: $settings)
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            updateFetchRequest()
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
    
    private func updateFetchRequest() {
        let newDate = Date()
        currentDateForFetch = newDate
        expenses.nsPredicate = NSPredicate(format: "%K >= %@ AND %K <= %@",
                                           argumentArray: [#keyPath(ExpensesEntity.expenseDate),
                                                           newDate.startOfDay as NSDate,
                                                           #keyPath(ExpensesEntity.expenseDate),
                                                           newDate.endDayOf as NSDate])
    }
    
    private func deleteExpense(expense: ExpensesEntity) {
        moc.delete(expense)
        try? moc.save()
    }
}

#Preview {
    @Environment(\.managedObjectContext) var moc
    @State var settings = Settings(moc: moc)
    return Group {
        TodayTabView(settings: $settings)
            .environment(\.managedObjectContext, ExpenseLogContainer(forPreview: true).persistentContainer.viewContext)
    }
}

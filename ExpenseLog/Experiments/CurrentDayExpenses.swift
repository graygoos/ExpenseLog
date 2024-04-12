//
//  CurrentDayExpenses.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 09/12/2023.
//

import SwiftUI

struct CurrentDayExpenses: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest<ExpensesEntity>(sortDescriptors: [SortDescriptor(\.itemName)])
    private var expenses
    @State private var newExpense = false
    
    @State private var showModal = false
    
    @Binding var settings: Settings
    
    var body: some View {
        List {
            ForEach(expenses) { expense in
                VStack(alignment: .leading) {
                    Text(expense.viewItemName)
                        .font(.title)
                    Text(expense.viewItemDescription)
                        .font(.subheadline)
                    Text(expense.paymentType ?? "nil")
                }
            }
        }
        .navigationTitle("ExpenseLog")
        .toolbar {
            ToolbarItem {
                Button(action: {
                    self.showModal.toggle()
                }) {
                    Image(systemName: "plus")
                }
                .sheet(isPresented: $showModal, onDismiss: {
                    print("expenseEntryView dismissed")
                }, content: {
                    ExpenseEntryView(settings: $settings)
                })
            }
        }
    }
}

#Preview {
    @Environment(\.managedObjectContext) var moc
    @State var settings = Settings(moc: moc)
    return CurrentDayExpenses(settings: $settings)
}

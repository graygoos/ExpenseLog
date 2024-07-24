//
//  DateSelectionView.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 23/07/2024.
//

import SwiftUI

struct DateSelectionView: View {
    @Binding var selectedDate: Date?
    let expenses: FetchedResults<ExpensesEntity>
    let onDismiss: () -> Void
    
    @Environment(\.dismiss) var dismiss
    @State private var tempSelectedDate = Date()
    @State private var showNoExpenseAlert = false
    
    var body: some View {
        NavigationStack {
            VStack {
                DatePicker(
                    "Select a date",
                    selection: $tempSelectedDate,
                    displayedComponents: [.date]
                )
                .datePickerStyle(GraphicalDatePickerStyle())
                .frame(maxHeight: 400)
                .onChange(of: tempSelectedDate) { oldDate, newDate in
                    if hasExpenses(on: newDate) {
                        selectedDate = newDate
                        dismiss()
                        onDismiss()
                    } else {
                        showNoExpenseAlert = true
                    }
                }
            }
            .navigationTitle("Select Date")
            .navigationBarItems(trailing: Button("Cancel") {
                dismiss()
                onDismiss()
            })
            .alert("No Expenses", isPresented: $showNoExpenseAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text("There are no expenses logged for \(tempSelectedDate.formatted(date: .long, time: .omitted))")
            }
        }
    }
    
    private func hasExpenses(on date: Date) -> Bool {
        return expenses.contains { expense in
            Calendar.current.isDate(expense.expenseDate!, inSameDayAs: date)
        }
    }
}

//#Preview {
//    DateSelectionView(selectedDate: .constant(Date()))
//}

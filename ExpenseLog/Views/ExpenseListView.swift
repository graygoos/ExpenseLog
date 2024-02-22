//
//  ExpenseListView.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 05/02/2024.
//

//import SwiftUI
//
//struct ExpenseListView: View {
//    var date: Date
//
//    var body: some View {
//        List(expenses, id: \.self) { expense in
//            // Display expense details here
//            Text(expense.itemName ?? "")
//        }
//        .navigationTitle("Expenses on \(date.formattedDay)")
//}
//
//#Preview {
//    ExpenseListView()
//}

/*
import SwiftUI

struct ExpenseListView: View {
    let date: Date
//    @FetchRequest(entity: ExpensesEntity.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \ExpensesEntity.expenseDate, ascending: false)], predicate: NSPredicate(format: "expenseDate >= %@ AND expenseDate < %@", argumentArray: [date, Calendar.current.date(byAdding: .day, value: 1, to: date)!]), animation: .default) var expenses: FetchedResults<ExpensesEntity>
    
    @FetchRequest(entity: ExpensesEntity.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \ExpensesEntity.expenseDate, ascending: true)], predicate: NSPredicate(format: "expenseDate == %@", argumentArray: [date as Any]), animation: .default) var expenses: FetchedResults<ExpensesEntity>
      
//       @FetchRequest var expenses: FetchedResults<ExpensesEntity>
       
       init(date: Date?) {
           self.date
           _expenses = FetchRequest(entity: ExpensesEntity.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \ExpensesEntity.expenseDate, ascending: true)],
                                    predicate: NSPredicate(format: "expenseDate == %@", argumentArray: [date as Any]), animation: .default)
       }

    var body: some View {
        List(expenses, id: \.self) { expense in
            // Display expense details here
            Text(expense.itemName ?? "")
        }
        .navigationTitle("Expenses on \(date.formattedDay)")
    }
}

*/


import SwiftUI

struct ExpenseListView: View {
    var date: Date?
    
//    var expenses: FetchedResults<ExpensesEntity>
    
//    @FetchRequest(entity: ExpensesEntity.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \ExpensesEntity.expenseDate, ascending: true)], predicate: NSPredicate(format: "expenseDate == %@", argumentArray: [date as Any]), animation: .default) var expenses: FetchedResults<ExpensesEntity>
    
   /*
    @FetchRequest(
        entity: ExpensesEntity.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \ExpensesEntity.expenseDate, ascending: true)],
        predicate: NSPredicate(format: "expenseDate == %@", argumentArray: [date as Any]),
        animation: .default
    ) var expenses: FetchedResults<ExpensesEntity>
    */
    
    init(date: Date?) {
        self.date = date
//        expenses = FetchRequest<ExpensesEntity>(entity: ExpensesEntity.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \ExpensesEntity.expenseDate, ascending: true)],
//                                 predicate: NSPredicate(format: "expenseDate == %@", argumentArray: [date as Any]), animation: .default)
    }
   
    var body: some View {
        VStack {
//            Text("\(expenses.count) expenses")
//            Text(self.date.formattedDay ?? "No date")
            List {
//                ForEach(expenses, id: \.self) { expense in
//                    Text("\(expense.itemAmount ?? 0) a text")
    //                Text("a text")
//                }
            }
            .navigationTitle("Expenses for \(date?.formattedDay ?? "")")
        }
//        .onAppear {
//            let request = FetchRequest<ExpensesEntity>(
//                entity: ExpensesEntity.entity(),
//                sortDescriptors: [NSSortDescriptor(keyPath: \ExpensesEntity.expenseDate, ascending: true)],
//                predicate: NSPredicate(format: "expenseDate == %@", argumentArray: [date as Any])
////                animation: .default
//            )
//            request.execute()
//        }
    }
}


#Preview {
    ExpenseListView(date: Date())
}


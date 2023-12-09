//
//  TodaysExpensesView.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 05/12/2023.
//

import SwiftUI

struct TodaysExpensesView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest<ExpensesEntity>(sortDescriptors: [])
    private var expenses
    @State private var newExpense = false
    
    var body: some View {

        VStack(alignment: .leading) {
            Text("05-12-2023")
                .font(.subheadline)
            HStack {
                Text("S/No:")
                Spacer()
                Text("Item")
                Spacer()
                Text("Quantity")
                Spacer()
                Text("Unit")
                Spacer()
                Text("Amount(₦)")
            }
            VStack {
                HStack {
                    Text("1")
                    Spacer()
                    Text("Biscuit")
                    Spacer()
                    Text("2")
                    Spacer()
                    Text("Pack")
                    Spacer()
                    Text("₦200.00")
                    
                }
            }
            HStack {
                Text("Total")
                    .font(.bold(.title2)())
                Spacer()
                Text("₦400.00")
                    .font(.bold(.title2)())
            }
        }
        .padding()
    }
}

/*
 Text("Show today's expenses here")
 Text("Item")
 Text("Amount")
 Text("Quantity")
 Text("Unit")
 Text("Total")
 Text("Biscuit")
 Text("200.00")
 Text("SHOPRITE")
 Text("1")
 Text("Digestive Hobnobs")
 Text("itemName")
 Text("itemAmount")
 Text("expenseDate")
 Text("05-12-2023")
 Text("NGN")
 Text("")
 
 addExpense(moc: moc, itemName: "Biscuits", itemAmount: 200, itemQuantity: 1, itemDescription: "Digestive Hobnobs", payee: "SHOPRITE", expenseTotal: 349, dailyTotal: 349, currency: "NGN", expenseDate: dateFormatter.date(from: "04-12-2023"))
 */

#Preview {
    TodaysExpensesView()
}

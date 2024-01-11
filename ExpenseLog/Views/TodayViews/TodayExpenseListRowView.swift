//
//  TodayExpenseListRowView.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 12/12/2023.
//

import SwiftUI

struct TodayExpenseListRowView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest<ExpensesEntity>(sortDescriptors: [SortDescriptor(\.itemName)])
    private var expenses
    
    var body: some View {
        HStack {
            Text("")
        }
    }
}

#Preview {
    TodayExpenseListRowView()
}

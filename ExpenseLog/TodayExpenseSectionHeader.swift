//
//  TodayExpenseSectionHeader.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 11/12/2023.
//

import SwiftUI

struct TodayExpenseSectionHeader: View {
    var body: some View {
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
    }
}

#Preview {
    TodayExpenseSectionHeader()
}

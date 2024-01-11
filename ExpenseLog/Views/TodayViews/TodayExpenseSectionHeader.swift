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
            Text("Item")
            Spacer()
            Text("Amount(₦)")
        }
    }
}

#Preview {
    TodayExpenseSectionHeader()
}

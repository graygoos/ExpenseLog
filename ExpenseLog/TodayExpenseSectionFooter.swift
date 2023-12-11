//
//  TodayExpenseSectionFooter.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 11/12/2023.
//

import SwiftUI

struct TodayExpenseSectionFooter: View {
    var body: some View {
        HStack {
            Text("Total")
                .font(.bold(.title2)())
            Spacer()
            Text("₦400.00")
                .font(.bold(.title2)())
        }
    }
}

#Preview {
    TodayExpenseSectionFooter()
}

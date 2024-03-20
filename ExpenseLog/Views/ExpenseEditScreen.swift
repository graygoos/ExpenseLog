//
//  ExpenseEditScreen.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 20/03/2024.
//

import SwiftUI

struct ExpenseEditScreen: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ExpenseFormView()
                .navigationTitle("Edit Expense")
        }
    }
}

#Preview {
    ExpenseEditScreen()
}

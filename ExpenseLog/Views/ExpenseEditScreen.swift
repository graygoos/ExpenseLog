//
//  ExpenseEditScreen.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 20/03/2024.
//

import SwiftUI

struct ExpenseEditScreen: View {
    let expense: ExpensesEntity?
    @Binding var model: ExpenseParameters
    
    @Binding var settings: Settings
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var showAlert = false
    
    var body: some View {
        NavigationStack {
            ExpenseFormView(model: $model, settings: $settings)
                .navigationTitle("Edit Expense")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {
                            print("cancel button tapped")
                            dismiss()
                        }) {
                            Text("Cancel")
                        }
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            if model.itemName.isEmpty || model.itemAmount == 0 {
                                showAlert = true
                            } else {
                                model.persistExpense()
                                dismiss()
                                print("save button tapped ✅")
                            }
                        }) {
                            Text("Save")
                        }
                    }
                }
                .alert(
                    "Title",
                    isPresented: $showAlert
                ) {
                    Button(role: .cancel) {
                        showAlert = false
                    } label: {
                        Text("Ok")
                    }
                } message: {
                    Text("Please fill in the item name and amount")
                }
        }
    }
}

//#Preview {
//    ExpenseEditScreen()
//}

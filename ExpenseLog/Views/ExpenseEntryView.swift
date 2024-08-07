//
//  ExpenseEntryView.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 15/11/2023.
//

import SwiftUI

struct ExpenseEntryView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var model: ExpenseParameters
    @State private var showAlert = false
    
    @Binding var settings: Settings
    
    init(settings: Binding<Settings>, initialDate: Date? = nil) {
        self._settings = settings
        self._model = State(initialValue: ExpenseParameters(expenseDate: initialDate ?? Date()))
    }
    
    var body: some View {
        NavigationStack {
            ExpenseFormView(model: $model, settings: $settings)
                .navigationTitle("Enter expense")
                .onAppear {
                    self.model.moc = moc
                }
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
                                print("save button tapped")
                            }
                        }) {
                            Text("Add")
                        }
                    }
                }
                .alert(
                    "Please add details",
                    isPresented: $showAlert
                ) {
                    Button(role: .cancel) {
                        showAlert = false
                    } label: {
                        Text("Ok")
                    }
                } message: {
                    Text("You need to have an item name and amount to save an expense")
                }
        }
    }
}

#Preview {
    @Environment(\.managedObjectContext) var moc
    @State var settings = Settings(moc: moc)
    return ExpenseEntryView(settings: $settings, initialDate: Date())
}



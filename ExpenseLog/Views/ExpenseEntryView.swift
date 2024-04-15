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
    
    @State private var model = ExpenseParameters()
    
    @Binding var settings: Settings

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
                            model.persistExpense()
                            dismiss()
                            print("save button tapped")
                        }) {
                            Text("Add")
                        }
                    }
                }
        }
    }
}

#Preview {
    @Environment(\.managedObjectContext) var moc
    @State var settings = Settings(moc: moc)
    return ExpenseEntryView(settings: $settings)
//    ExpenseEntryView()
}



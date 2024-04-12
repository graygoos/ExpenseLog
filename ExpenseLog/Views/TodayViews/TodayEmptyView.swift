//
//  TodayEmptyView.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 09/12/2023.
//

import SwiftUI

struct TodayEmptyView: View {
    @State private var showModal = false
    
    @Binding var settings: Settings
    var body: some View {
        ContentUnavailableView(label: {
            Label("No Expense logged today.", systemImage: "creditcard.fill")
        }, description: {
            Text("Logged expenses for the day will be listed here.")
        }, actions: {
            Button(action: {
                self.showModal.toggle()
            }) {
                Text("Add Expense")
            }
            .buttonStyle(.borderedProminent)
            .sheet(isPresented: $showModal, onDismiss: {
                print("expenseEntryView dismissed")
            }, content: {
                ExpenseEntryView(settings: $settings)
            })
        })
    }
}

#Preview {
    @Environment(\.managedObjectContext) var moc
    @State var settings = Settings(moc: moc)
    return TodayEmptyView(settings: $settings)
}

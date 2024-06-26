//
//  HistoryEmptyScreen.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 05/04/2024.
//

import SwiftUI

struct HistoryEmptyScreen: View {
    @State private var showModal = false
    
    @Binding var settings: Settings
    
    var body: some View {
        ContentUnavailableView(label: {
            Label("No previous expense logged.", systemImage: "clock.fill")
        }, description: {
            Text("Past expenses will be listed here.")
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
    return HistoryEmptyScreen(settings: $settings)
}

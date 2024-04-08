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
    
//    @FetchRequest(entity: SettingsEntity.entity(), sortDescriptors: []) var settings: FetchedResults<SettingsEntity>
    
    @Binding var settings: Settings
        
    
//    @State private var showPaymentDetailsSection =      false
//    @State private var showQuantitySection =            false
//    @State private var showVendorSection =              false
//    @State private var showLocationSection =            false
//    @State private var showDescriptionSection =         false
//    @State private var showFrequencySection =           false
//    @State private var showCategorySection =            false
    
    var body: some View {
        NavigationStack {
            ExpenseFormView(model: $model, settings: $settings)
                .navigationTitle("Enter expense")
                .onAppear {
                    self.model.moc = moc
//                    updateSettings()
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
    
//    private func updateSettings() {
//        if let settingsEntity = $settings.first {
//            model.showPaymentDetailsSection = settingsEntity.showPaymentDetailsSection
//            model.showQuantitySection = settingsEntity.showQuantitySection
//            model.showVendorSection = settingsEntity.showVendorSection
//            model.showLocationSection = settingsEntity.showLocationSection
//            model.showDescriptionSection = settingsEntity.showDescriptionSection
//            model.showFrequencySection = settingsEntity.showFrequencySection
//            model.showCategorySection = settingsEntity.showCategorySection
//        }
//        do {
//        try moc.save()
//        
//    } catch {
//        print("Error updating setting: \(error.localizedDescription)")
//    }
//    }
}

#Preview {
    @State var settings = Settings()
    return ExpenseEntryView(settings: $settings)
//    ExpenseEntryView()
}



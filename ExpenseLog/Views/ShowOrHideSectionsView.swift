//
//  ShowOrHideSectionsView.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 21/03/2024.
//

import SwiftUI


struct ShowOrHideSectionsView: View {
    @Environment(\.managedObjectContext) private var moc
    
    @FetchRequest(entity: SettingsEntity.entity(), sortDescriptors: []) var settings: FetchedResults<SettingsEntity>
    
//    @State private var showPaymentDetailsSection = UserDefaults.standard.bool(forKey: "showPaymentSection")
////    @State private var showRecurringSection = UserDefaults.standard.bool(forKey: "showRecurringSection")
//    @State private var showQuantitySection = UserDefaults.standard.bool(forKey: "showQuantitySection")
//    @State private var showVendorSection = UserDefaults.standard.bool(forKey: "showVendorSection")
//    @State private var showLocationSection = UserDefaults.standard.bool(forKey: "showLocationSection")
//    @State private var showDescriptionSection = UserDefaults.standard.bool(forKey: "showDescriptionSection")
//    @State private var showFrequencySection = UserDefaults.standard.bool(forKey: "showFrequencySection")
    
    var body: some View {
            Section {
//                Toggle("Payment Details", isOn: $showPaymentDetailsSection)
//                Toggle("Item Quantity Details", isOn: $showQuantitySection)
//                Toggle("Vendor", isOn: $showVendorSection)
//                Toggle("Location", isOn: $showLocationSection)
//                Toggle("Item Description", isOn: $showDescriptionSection)
//                Toggle("Expense Frequency", isOn: $showFrequencySection)
                
                ForEach(SettingKeys.allCases, id: \.self) { key in
                    ToggleView(settings: settings.first ?? createDefaultSettings(), key: key)
                }
            }
//            .onDisappear {
//                // Save settings to UserDefaults when leaving the view
//                UserDefaults.standard.set(showPaymentDetailsSection, forKey: "showPaymentDetailsSection")
//                UserDefaults.standard.set(showQuantitySection, forKey: "showQuantitySection")
//                UserDefaults.standard.set(showVendorSection, forKey: "showVendorSection")
//                UserDefaults.standard.set(showLocationSection, forKey: "showLocationSection")
//                UserDefaults.standard.set(showDescriptionSection, forKey: "showDescriptionSection")
//                UserDefaults.standard.set(showFrequencySection, forKey: "showFrequencySection")
//            }
    }
    
    private func createDefaultSettings() -> SettingsEntity {
        let settings = SettingsEntity(context: moc)
        settings.showPaymentDetailsSection = SettingKeys.paymentDetails.defaultValue
        settings.showQuantitySection = SettingKeys.quantity.defaultValue
        settings.showVendorSection = SettingKeys.vendor.defaultValue
        settings.showLocationSection = SettingKeys.location.defaultValue
        settings.showDescriptionSection = SettingKeys.description.defaultValue
        settings.showFrequencySection = SettingKeys.frequency.defaultValue
        settings.showCategorySection = SettingKeys.frequency.defaultValue
        
        return settings
    }
}

#Preview {
    ShowOrHideSectionsView()
}

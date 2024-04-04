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
    
    var body: some View {
            Section {
                ForEach(SettingKeys.allCases, id: \.self) { key in
                    ToggleView(settings: settings.first ?? createDefaultSettings(), key: key)
                }
            }
    }
    
    private func createDefaultSettings() -> SettingsEntity {
        let settings = SettingsEntity(context: moc)
        settings.showPaymentDetailsSection = SettingKeys.paymentDetails.defaultValue
        settings.showQuantitySection = SettingKeys.quantity.defaultValue
        settings.showVendorSection = SettingKeys.vendor.defaultValue
        settings.showLocationSection = SettingKeys.location.defaultValue
        settings.showDescriptionSection = SettingKeys.description.defaultValue
        settings.showFrequencySection = SettingKeys.frequency.defaultValue
        settings.showCategorySection = SettingKeys.category.defaultValue
        
        return settings
    }
}

#Preview {
    ShowOrHideSectionsView()
}

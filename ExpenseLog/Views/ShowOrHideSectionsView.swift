//
//  ShowOrHideSectionsView.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 21/03/2024.
//

import SwiftUI


struct ShowOrHideSectionsView: View {
    @Environment(\.managedObjectContext) private var moc
    
//    @FetchRequest(entity: SettingsEntity.entity(), sortDescriptors: []) var settings: FetchedResults<SettingsEntity>
    
//    @State private var setting: SettingsEntity?
    
    @State private var settings = Settings(showFormSection: false)
    
    var body: some View {
        VStack {
//            Text("\(settings.count) settings entities")
//            Button("Clean data") {
//                cleanUpExcessSettings()
//            }
            Section {
                    ForEach(SettingKeys.allCases, id: \.self) { key in
                        ToggleView(key: key, settings: $settings)
                    }
            }
        }
    }
    
    /*
    private func createDefaultSettings() -> SettingsEntity {
        if self.setting != nil { return self.setting! }
        self.setting = self.settings.first
        if self.setting != nil { return self.setting! }
        let settings = SettingsEntity(context: moc)
        self.setting = settings
//        if !self.settings.isEmpty {
//            settings = self.settings.first!
//        }
//        let settings = SettingsEntity(context: moc)
        settings.showPaymentDetailsSection = SettingKeys.paymentDetails.defaultValue
        settings.showQuantitySection = SettingKeys.quantity.defaultValue
        settings.showVendorSection = SettingKeys.vendor.defaultValue
        settings.showLocationSection = SettingKeys.location.defaultValue
        settings.showDescriptionSection = SettingKeys.description.defaultValue
        settings.showFrequencySection = SettingKeys.frequency.defaultValue
        settings.showCategorySection = SettingKeys.category.defaultValue
        
        do {
            try moc.save()
        } catch {
            print("Error saving settings: \(error.localizedDescription)")
        }
        
        return settings
    }
    */
    /* create Settings Model file */
    
    /*
    private func cleanUpExcessSettings() {
        print("✅❓✅😂", settings.count)
        for entity in self.settings {
            moc.delete(entity)
        }
        do {
            try moc.save()
        } catch {
            print("Error saving settings: \(error.localizedDescription)")
        }
        print(settings.count)
    }
    */
}

#Preview {
    ShowOrHideSectionsView()
}

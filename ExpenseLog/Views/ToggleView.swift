//
//  ToggleView.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 23/03/2024.
//

import SwiftUI

struct ToggleView: View {
    var key: SettingKeys
    @Environment(\.managedObjectContext) private var moc
    
    @Binding var settings: Settings
    
    var body: some View {
        Toggle(key.title, isOn: self.toggleBinding(for: key))
            .toggleStyle(SwitchToggleStyle(tint: .accent))
            .onChange(of: self.keySetting(for: key)) { oldValue, newValue in
                key.updateSetting(using: moc, value: newValue)
            }
    }
    
    private func toggleBinding(for key: SettingKeys) -> Binding<Bool> {
        switch key {
        case .quantity:         return $settings.showQuantitySection
        case .vendor:           return $settings.showVendorSection
        case .location:         return $settings.showLocationSection
        case .description:      return $settings.showDescriptionSection
        case .paymentDetails:   return $settings.showPaymentDetailsSection
        case .frequency:        return $settings.showFrequencySection
        case .category:         return $settings.showCategorySection
        case .defaultCurrency:
            // This case shouldn't be used for toggles, but we need to handle it
            return Binding.constant(false)
        }
    }
    
    private func keySetting(for key: SettingKeys) -> Bool {
        switch key {
        case .quantity:         return settings.showQuantitySection
        case .vendor:           return settings.showVendorSection
        case .location:         return settings.showLocationSection
        case .description:      return settings.showDescriptionSection
        case .paymentDetails:   return settings.showPaymentDetailsSection
        case .frequency:        return settings.showFrequencySection
        case .category:         return settings.showCategorySection
        case .defaultCurrency:
            // This case shouldn't be used for toggles, but we need to handle it
            return false
        }
    }
}

//#Preview {
//    ToggleView(key: .location)
//}

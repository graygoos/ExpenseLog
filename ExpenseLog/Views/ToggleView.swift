//
//  ToggleView.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 23/03/2024.
//

import SwiftUI

struct ToggleView: View {
//    @State private var isOn: Bool = false
//    @ObservedObject var settings: SettingsEntity
    var key: SettingKeys
    @Environment(\.managedObjectContext) private var moc
    
    @Binding var settings: Settings
    
    var body: some View {
        Toggle(key.title, isOn: self.toggleBinding(for: key))
            .onChange(of: self.keySetting(for: key)) { oldValue, newValue in
                key.updateSetting(using: moc, key: key, value: newValue)

            }
//            .onAppear {
//                self.isOn = key.fetchSetting(using: settings)
//            }
//            .onChange(of: isOn) { oldVal, newValue in 
//                key.updateSetting(using: moc, value: newValue)
//            }
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
        }
    }
    
//    private func saveSettings() {
//        do {
//            try settings.managedObjectContext?.save()
//        } catch {
//            print("Error saving settings: \(error.localizedDescription)")
//        }
//    }
}

//#Preview {
//    ToggleView(key: .location)
//}

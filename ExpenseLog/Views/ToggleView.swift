//
//  ToggleView.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 23/03/2024.
//

import SwiftUI

struct ToggleView: View {
    @State private var isOn: Bool = false
    @ObservedObject var settings: SettingsEntity
    var key: SettingKeys
    
    var body: some View {
        Toggle(key.title, isOn: $isOn)
            .onAppear {
                self.isOn = self.key.value
            }
            .onChange(of: isOn) {
                self.key.assign(isOn)
            }
    }
    
    private func toggleBinding(for key: SettingKeys) -> Binding<Bool> {
        switch key {
        case .quantity: return $settings.showQuantitySection
        case .vendor:
            return $settings.showVendorSection
        case .location:
            return $settings.showLocationSection
        case .description:
            return $settings.showDescriptionSection
        case .paymentDetails:
            return $settings.showPaymentDetailsSection
        case .frequency:
            return $settings.showFrequencySection
        case .category:
            return $settings.showCategorySection
        }
    }
    
    private func saveSettings() {
        do {
            try settings.managedObjectContext?.save()
        } catch {
            print("Error saving settings: \(error.localizedDescription)")
        }
    }
}

//#Preview {
//    ToggleView(key: .location)
//}

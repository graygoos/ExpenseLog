//
//  Settings.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 05/04/2024.
//

import Foundation
import Combine
import CoreData

@Observable
class Settings: ObservableObject, Equatable {
    static func == (lhs: Settings, rhs: Settings) -> Bool {
        lhs.showQuantitySection == rhs.showQuantitySection &&
        lhs.showVendorSection == rhs.showVendorSection &&
        lhs.showLocationSection == rhs.showLocationSection &&
        lhs.showDescriptionSection == rhs.showDescriptionSection &&
        lhs.showPaymentDetailsSection == rhs.showPaymentDetailsSection &&
        lhs.showFrequencySection == rhs.showFrequencySection &&
        lhs.showCategorySection == rhs.showCategorySection
        return lhs.defaultCurrency == rhs.defaultCurrency
    }
    
    var showQuantitySection =       false
    var showVendorSection =         false
    var showLocationSection =       false
    var showDescriptionSection =    false
    var showPaymentDetailsSection = false
    var showFrequencySection =      false
    var showCategorySection =       false
    var defaultCurrency: String

    init(moc: NSManagedObjectContext) {
        let fetchRequest: NSFetchRequest<SettingsEntity> = SettingsEntity.fetchRequest()
        do {
            let result = try moc.fetch(fetchRequest)
            if let entity = result.first {
                self.showQuantitySection = entity.showQuantitySection
                self.showVendorSection = entity.showVendorSection
                self.showLocationSection = entity.showLocationSection
                self.showDescriptionSection = entity.showDescriptionSection
                self.showPaymentDetailsSection = entity.showPaymentDetailsSection
                self.showFrequencySection = entity.showFrequencySection
                self.showCategorySection = entity.showCategorySection
                self.defaultCurrency = entity.defaultCurrency ?? Settings.getDeviceDefaultCurrency()
            } else {
                // If no settings entity exists, create one with device default currency
                let newEntity = SettingsEntity(context: moc)
                self.defaultCurrency = Settings.getDeviceDefaultCurrency()
                newEntity.defaultCurrency = self.defaultCurrency
                try moc.save()
            }
        } catch {
            print("Error initializing Settings: \(error)")
            self.defaultCurrency = Settings.getDeviceDefaultCurrency()
        }
    }
    
    static func getDeviceDefaultCurrency() -> String {
        return Locale.current.currency?.identifier ?? "USD"
    }
}

//
//  SettingKeys.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 23/03/2024.
//

import Foundation
import CoreData

enum SettingKeys: CustomStringConvertible, CaseIterable {
    case quantity, vendor, location, description, paymentDetails, frequency, category
    case defaultCurrency
    
    var description: String {
        switch self {
        case .quantity: return "showQuantitySection"
        case .vendor: return "showVendorSection"
        case .location: return "showLocationSection"
        case .description: return "showDescriptionSection"
        case .paymentDetails: return "showPaymentDetailsSection"
        case .frequency: return "showFrequencySection"
        case .category: return "showCategorySection"
        case .defaultCurrency: return "defaultCurrency"
        }
    }
    
    var title: String {
        switch self {
        case .quantity: return "Quantity Section"
        case .vendor: return "Vendor Section"
        case .location: return "Location Section"
        case .description: return "Item Description"
        case .paymentDetails: return "Payment Details Section"
        case .frequency: return "Frequency Section"
        case .category: return "Category Section"
        case .defaultCurrency: return "Default Currency"
        }
    }
    
    var defaultValue: Any {
        switch self {
        case .defaultCurrency: return Settings.getDeviceDefaultCurrency()
        default: return false
        }
    }
    
    func fetchSetting(using moc: NSManagedObjectContext) -> Any {
        let fetchRequest: NSFetchRequest<SettingsEntity> = SettingsEntity.fetchRequest()
        do {
            let result = try moc.fetch(fetchRequest)
            if let settingsEntity = result.first {
                switch self {
                case .quantity: return settingsEntity.showQuantitySection
                case .vendor: return settingsEntity.showVendorSection
                case .location: return settingsEntity.showLocationSection
                case .description: return settingsEntity.showDescriptionSection
                case .paymentDetails: return settingsEntity.showPaymentDetailsSection
                case .frequency: return settingsEntity.showFrequencySection
                case .category: return settingsEntity.showCategorySection
                case .defaultCurrency: return settingsEntity.defaultCurrency ?? Settings.getDeviceDefaultCurrency()
                }
            }
        } catch {
            print("Error fetching settings: \(error.localizedDescription)")
        }
        return defaultValue
    }
    
    func updateSetting(using moc: NSManagedObjectContext, value: Any) {
        let fetchRequest: NSFetchRequest<SettingsEntity> = SettingsEntity.fetchRequest()
        do {
            let result = try moc.fetch(fetchRequest)
            let settingsEntity = result.first ?? SettingsEntity(context: moc)
            
            switch self {
            case .quantity: settingsEntity.showQuantitySection = value as? Bool ?? false
            case .vendor: settingsEntity.showVendorSection = value as? Bool ?? false
            case .location: settingsEntity.showLocationSection = value as? Bool ?? false
            case .description: settingsEntity.showDescriptionSection = value as? Bool ?? false
            case .paymentDetails: settingsEntity.showPaymentDetailsSection = value as? Bool ?? false
            case .frequency: settingsEntity.showFrequencySection = value as? Bool ?? false
            case .category: settingsEntity.showCategorySection = value as? Bool ?? false
            case .defaultCurrency: settingsEntity.defaultCurrency = value as? String ?? Settings.getDeviceDefaultCurrency()
            }
            
            try moc.save()
            print("❓update settings saved", self)
        } catch {
            print("Error updating setting: \(error.localizedDescription)")
        }
    }
}

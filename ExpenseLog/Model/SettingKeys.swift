//
//  SettingKeys.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 23/03/2024.
//

import Foundation
import CoreData

enum SettingKeys: CustomStringConvertible, CaseIterable {
    case quantity
    case vendor
    case location
    case description
    case paymentDetails
    case frequency
    case category
    
    var description: String {
        get {
            switch self {
            case .quantity: return "showQuantitySection"
            case .vendor: return "showVendorSection"
            case .location: return "showLocationSection"
            case .description: return "showDescriptionSection"
            case .paymentDetails: return "showPaymentDetailsSection"
            case .frequency: return "showFrequencySection"
            case .category: return "showCategorySection"
            }
        }
    }
    var title: String {
        get {
            switch self {
            case .quantity: return "Quantity Section"
            case .vendor: return "Vendor Section"
            case .location: return "Location Section"
            case .description: return "Item Description"
            case .paymentDetails: return "Payment Details Section"
            case .frequency: return "Frequency Section"
            case .category: return "Category Section"
            }
        }
    }
//    var icon: String {
//        get {
//            switch self {
//            case .quantity: return " "
//            default: return "?"
//            }
//        }
//    }
    var defaultValue: Bool {
//        get {
//            switch self {
//            case .quantity: return false
//            case .vendor: return false
//            case .location: return false
//            case .description: return false
//            case .paymentDetails: return false
//            case .frequency: return false
//            case.category: return false
////            default: return false
//            }
//        }
        false
    }
    
    
//    var value: Bool {
//        get {
//            UserDefaults.standard.bool(forKey: self.description)
//        }
//        set(newValue) {
//            UserDefaults.standard.set(newValue, forKey: self.description)
//        }
//    }
//    
//    func assign(_ value: Bool) {
//        UserDefaults.standard.set(value, forKey: self.description)
//    }
    
    // Fetch setting from CoreData
        func fetchSetting(using moc: NSManagedObjectContext) -> Bool {
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
                    }
                }
            } catch {
                print("Error fetching settings: \(error.localizedDescription)")
            }
            return false
        }
        
        // Update setting in CoreData
    func updateSetting(using moc: NSManagedObjectContext, key: SettingKeys, value: Bool) {
        let fetchRequest: NSFetchRequest<SettingsEntity> = SettingsEntity.fetchRequest()
        do {
            let result = try moc.fetch(fetchRequest)
            if let settingsEntity = result.first {
                switch key {
                case .quantity: settingsEntity.showQuantitySection = value
                case .vendor: settingsEntity.showVendorSection = value
                case .location: settingsEntity.showLocationSection = value
                case .description: settingsEntity.showDescriptionSection = value
                case .paymentDetails: settingsEntity.showPaymentDetailsSection = value
                case .frequency: settingsEntity.showFrequencySection = value
                case .category: settingsEntity.showCategorySection = value
                }
                try moc.save() // Save changes to Core Data
            } else {
                // If settings entity doesn't exist, create and save new settings entity
                let newSettingsEntity = SettingsEntity(context: moc)
                newSettingsEntity.showQuantitySection = key == .quantity ? value : false
                newSettingsEntity.showVendorSection = key == .vendor ? value : false
                newSettingsEntity.showLocationSection = key == .location ? value : false
                newSettingsEntity.showDescriptionSection = key == .description ? value : false
                newSettingsEntity.showPaymentDetailsSection = key == .paymentDetails ? value : false
                newSettingsEntity.showFrequencySection = key == .frequency ? value : false
                newSettingsEntity.showCategorySection = key == .category ? value : false
                try moc.save() // Save changes to Core Data
            }
        } catch {
            print("Error updating setting: \(error.localizedDescription)")
        }
    }
    
    
//        func updateSetting(using moc: NSManagedObjectContext, value: Bool) {
//            let fetchRequest: NSFetchRequest<SettingsEntity> = SettingsEntity.fetchRequest()
//            do {
//                let result = try moc.fetch(fetchRequest)
//                if let settingsEntity = result.first {
//                    switch self {
//                    case .quantity: settingsEntity.showQuantitySection = value
//                    case .vendor: settingsEntity.showVendorSection = value
//                    case .location: settingsEntity.showLocationSection = value
//                    case .description: settingsEntity.showDescriptionSection = value
//                    case .paymentDetails: settingsEntity.showPaymentDetailsSection = value
//                    case .frequency: settingsEntity.showFrequencySection = value
//                    case .category: settingsEntity.showCategorySection = value
//                    }
//                    try moc.save()
//                } else {
//                    // create and save new settings entity
//                }
//            } catch {
//                print("Error updating setting: \(error.localizedDescription)")
//            }
//        }
}

//
//  SettingKeys.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 23/03/2024.
//

import Foundation

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
        get {
            switch self {
            case .quantity: return true
            default: return false
            }
        }
    }
    
    
    var value: Bool {
        get {
            UserDefaults.standard.bool(forKey: self.description)
        }
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: self.description)
        }
    }
    
    func assign(_ value: Bool) {
        UserDefaults.standard.set(value, forKey: self.description)
    }
}

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
    
    var description: String {
        get {
            switch self {
            case .quantity: return "showQuantitySection"
            case .vendor: return "showVendorSection"
            case .location: return "showLocationSection"
            }
        }
    }
    var title: String {
        get {
            switch self {
            case .quantity: return "Quantity Section"
            case .vendor: return "Vendor Section"
            case .location: return "Location Section"
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

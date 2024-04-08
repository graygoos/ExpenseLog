//
//  Settings.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 05/04/2024.
//

import Foundation
import Combine

@Observable
class Settings: ObservableObject, Equatable {
    static func == (lhs: Settings, rhs: Settings) -> Bool {
//        return lhs.showFormSection == rhs.showFormSection &&
        lhs.showQuantitySection == rhs.showQuantitySection &&
        lhs.showVendorSection == rhs.showVendorSection &&
        lhs.showLocationSection == rhs.showLocationSection &&
        lhs.showDescriptionSection == rhs.showDescriptionSection &&
        lhs.showPaymentDetailsSection == rhs.showPaymentDetailsSection &&
        lhs.showFrequencySection == rhs.showFrequencySection &&
        lhs.showCategorySection == rhs.showCategorySection
    }
    
//    var showFormSection: Bool
    
    var showQuantitySection =       false
    var showVendorSection =         false
    var showLocationSection =       false
    var showDescriptionSection =    false
    var showPaymentDetailsSection = false
    var showFrequencySection =      false
    var showCategorySection =       false
    
//    init(showFormSection: Bool) {
//        self.showQuantitySection = s
//        
//    }
    
    
    
    func saveExpenseFormSetting() {
        
    }
}

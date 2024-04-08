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
        return lhs.showFormSection == rhs.showFormSection &&
        lhs.showQuantitySection == rhs.showQuantitySection &&
        lhs.showVendorSection == rhs.showVendorSection &&
        lhs.showLocationSection == rhs.showLocationSection &&
        lhs.showDescriptionSection == rhs.showDescriptionSection &&
        lhs.showPaymentDetailsSection == rhs.showPaymentDetailsSection &&
        lhs.showFrequencySection == rhs.showFrequencySection &&
        lhs.showCategorySection == rhs.showCategorySection
    }
    
    var showFormSection: Bool
    
    var showQuantitySection =       Bool()
    var showVendorSection =         Bool()
    var showLocationSection =       Bool()
    var showDescriptionSection =    Bool()
    var showPaymentDetailsSection = Bool()
    var showFrequencySection =      Bool()
    var showCategorySection =       Bool()
    
    init(showFormSection: Bool) {
        self.showFormSection = showFormSection
        
    }
    
    
    
    func saveExpenseFormSetting() {
        
    }
}

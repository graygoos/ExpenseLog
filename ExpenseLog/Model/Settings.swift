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
    }
    
    var showQuantitySection =       false
    var showVendorSection =         false
    var showLocationSection =       false
    var showDescriptionSection =    false
    var showPaymentDetailsSection = false
    var showFrequencySection =      false
    var showCategorySection =       false

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
            }
        } catch {
            print("Eror")
        }
    }
}

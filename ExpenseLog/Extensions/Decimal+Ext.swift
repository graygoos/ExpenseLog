//
//  Decimal+Ext.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 24/01/2024.
//

import Foundation

extension Decimal {
    func currencyFormattedString() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "NGN"
        
        return formatter.string(from: self as NSDecimalNumber) ?? ""
    }
}

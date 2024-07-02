//
//  SFSymbolManager.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 02/07/2024.
//

import Foundation
import SwiftUI

struct SFSymbolManager {
    static func symbolForPaymentType(_ paymentType: String) -> String {
        switch paymentType {
        case "Debit Card":
            return "creditcard.fill"
        case "Cash":
            return "banknote.fill"
        case "Electronic Funds Transfer":
            return "arrow.right.arrow.left.circle.fill"
        case "Credit Card":
            return "creditcard.fill"
        case "Cheque":
            return "checkmark.rectangle.fill"
        case "Cryptocurrency":
            return "bitcoinsign.circle.fill"
        case "Bank App":
            return "iphone.homebutton"
        case "USSD":
            return "number"
        default:
            return "creditcard.fill"
        }
    }
}

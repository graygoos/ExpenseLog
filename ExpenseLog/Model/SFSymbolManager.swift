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
    
    static func symbolForCategory(_ category: String) -> String {
        switch category {
        case "Non":
            return "questionmark.circle"
        case "Food & Dining":
            return "fork.knife"
        case "Groceries":
            return "cart.fill"
        case "Transportation":
            return "car.fill"
        case "Utilities (Electricity, Water, Gas)":
            return "bolt.fill"
        case "Rent":
            return "house.fill"
        case "Mortgage":
            return "house.circle.fill"
        case "Entertainment":
            return "music.note"
        case "Healthcare":
            return "heart.fill"
        case "Health & Fitness":
            return "figure.walk"
        case "Shopping":
            return "bag.fill"
        case "Personal Care":
            return "person.crop.circle"
        case "Travel":
            return "airplane"
        case "Insurance":
            return "shield.fill"
        case "Education":
            return "book.fill"
        case "Debt Payments":
            return "banknote.fill"
        case "Investments":
            return "chart.bar.fill"
        case "Gifts & Donations":
            return "gift.fill"
        case "Home Maintenance":
            return "hammer.fill"
        case "Pet Care":
            return "pawprint.fill"
        case "Taxes":
            return "doc.text"
        case "Subscriptions & Memberships":
            return "doc.text.below.ecg"
        case "Miscellaneous":
            return "ellipsis.circle"
        default:
            return "questionmark.circle"
        }
    }
}

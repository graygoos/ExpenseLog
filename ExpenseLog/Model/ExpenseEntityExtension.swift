//
//  ExpenseEntityExtension.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 04/12/2023.
//

import CoreData
import SwiftUI

extension ExpensesEntity {
    var viewItemName: String {
        itemName ?? "[Enter Expense]"
    }
    
    var viewItemDescription: String {
        itemDescription ?? "No Description"
    }
    
    var viewItemUnit: String {
        itemUnit ?? "No Unit"
    }
    
    var viewItemAmount: String {
        "\(itemAmount ?? 0)"
    }
    
    var viewItemQuantity: String {
        "\(itemQuantity)"
    }
    
    var viewPayee: String {
        payee ?? "No Vendor entered"
    }
    
    var viewPaymentType: String {
        paymentType ?? "No Payment Type selected"
    }
    
    var viewCurrency: String {
        expenseCurrency ?? "No currency selected"
    }
    
    var viewExpenseLocation: String {
        expenseLocation ?? "No Location entered"
    }
    
    var viewExpenseID: String {
        expenseID?.uuidString ?? ""
    }
    
    var viewTimeEntered: String {
        return "Time Entered: " + (timeEntered?.formatted(date: .numeric, time: .omitted) ?? "N/A")
    }
    
    var viewExpenseDate: String {
        if let expenseDate = expenseDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy" // Ensure this matches the format expected
            
            return dateFormatter.string(from: expenseDate)
        } else {
            return "N/A"
        }
    }
}

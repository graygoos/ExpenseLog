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
        return "Expense Date: " + (timeEntered?.formatted(date: .numeric, time: .omitted) ?? "N/A")
    }
}

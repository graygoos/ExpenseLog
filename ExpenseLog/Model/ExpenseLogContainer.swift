//
//  ExpenseLogContainer.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 15/11/2023.
//

import CoreData

class ExpenseLogContainer {
    let persistentContainer: NSPersistentContainer
    
    init() {
        persistentContainer = NSPersistentContainer(name: "ExpensesDataModel")
        persistentContainer.loadPersistentStores { _, _ in }
    }
    
    init(forPreview: Bool = false) {
        persistentContainer = NSPersistentContainer(name: "ExpensesDataModel")
        
        /* BOOK NOTE:
         This is nil by default. Having an UndoManger adds overhead. Try to avoid a large number of uncommitted changes.
         */
        persistentContainer.viewContext.undoManager = UndoManager()
        persistentContainer.viewContext.undoManager?.levelsOfUndo = 5
        
        if forPreview {
            persistentContainer.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        persistentContainer.loadPersistentStores { _, _ in }
        
        if forPreview {
            addMockData(moc: persistentContainer.viewContext)
        }
    }
}

extension ExpenseLogContainer {
    
    func addMockData(moc: NSManagedObjectContext) {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withFullDate, .withTime, .withDashSeparatorInDate, .withColonSeparatorInTime]
        
        addExpense(moc: moc, itemName: "Biscuits", itemAmount: 200, itemQuantity: 1, itemDescription: "Digestive Hobnobs", payee: "SHOPRITE", expenseTotal: 349, expenseCurrency: "NGN", expenseDate: dateFormatter.date(from: "24-01-2024"), paymentType: "Cash", itemUnit: "Pack")
        
        addExpense(moc: moc, itemName: "Chocolate", itemAmount: 650, itemQuantity: 2, itemDescription: "Mars Chocolate", payee: "SHOPRITE", expenseTotal: 1300, expenseCurrency: "NGN", expenseDate: dateFormatter.date(from: "22-02-2024"), paymentType: "Debit Card", itemUnit: "Box")
        
        addExpense(moc: moc, itemName: "Canoe Soap", itemAmount: 250, itemQuantity: 2, itemDescription: "Washing Soap", payee: "SHOPRITE", expenseTotal: 500, expenseCurrency: "NGN", expenseDate: dateFormatter.date(from: "19-02-2024"), paymentType: "Cash", itemUnit: "Bar")
        
        addExpense(moc: moc, itemName: "AirPods", itemAmount: 1000, itemQuantity: 1, itemDescription: "Wireless Earphones", payee: "SHOPRITE", expenseTotal: 500, expenseCurrency: "NGN", expenseDate: dateFormatter.date(from: "25-01-2024"), paymentType: "Debit Card", itemUnit: "Pair")
        
        addExpense(moc: moc, itemName: "AirPods Pro", itemAmount: 100000, itemQuantity: 1, itemDescription: "Wireless Earphones", payee: "SHOPRITE", expenseTotal: 500, expenseCurrency: "NGN", expenseDate: dateFormatter.date(from: "31-01-2024"), paymentType: "Debit Card", itemUnit: "Pair")
        
        addExpense(moc: moc, itemName: "Apple Vision Pro", itemAmount: 3500, itemQuantity: 1, itemDescription: "XR headset", payee: "www.apple.com", expenseTotal: 500, expenseCurrency: "USD", expenseDate: dateFormatter.date(from: "25-03-2024"), paymentType: "Debit Card", itemUnit: "Pair")
        
        try? moc.save()
    }
    
    func addExpense(moc: NSManagedObjectContext, itemName: String, itemAmount: Decimal, itemQuantity: Double, itemDescription: String, payee: String, expenseTotal: 
                    Decimal, expenseCurrency: String, expenseDate: Date?, paymentType: String, itemUnit: String) {
        let expense = ExpensesEntity(context: moc)
        
        expense.itemName = itemName
        expense.itemAmount = NSDecimalNumber(decimal: itemAmount)
        expense.itemQuantity = Int16(itemQuantity)
        expense.itemDescription = itemDescription
        expense.payee = payee
        expense.expenseTotal = NSDecimalNumber(decimal: expenseTotal)
//        expense.dailyTotal = dailyTotal
        expense.expenseCurrency = expenseCurrency
        expense.paymentType = paymentType
        expense.itemUnit = itemUnit
//        expense.expenseDate = expenseDate
        expense.expenseDate = convertToUTC(from: expenseDate!)
    }
    
    
    func convertToUTC(from date: Date) -> Date {
        let calendar = Calendar.current
        var components = calendar.dateComponents(in: TimeZone.current, from: date)
        components.hour = 0
        components.minute = 0
        components.second = 0
        let utcCalendar = Calendar(identifier: .gregorian)
        
        return utcCalendar.date(from: components)!
    }
}

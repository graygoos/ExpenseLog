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
//    func addMockData(moc: NSManagedObjectContext) {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "MM-dd-yyyy"
//        
//        addTask(moc: moc, taskName: "Get gift for anniversary", done: false, dueDate: dateFormatter.date(from: "7-06-2022")!, priority: 3)
//        addTask(moc: moc, taskName: "Prepare for sale", done: false, dueDate: dateFormatter.date(from: "8-27-2022")!, priority: 2)
//        addTask(moc: moc, taskName: "Marketing meeting", done: false, dueDate: dateFormatter.date(from: "6-25-2022")!, priority: 1)
//        addTask(moc: moc, taskName: "Get milk", done: true, dueDate: dateFormatter.date(from: "4-17-2022")!, priority: 1)
//
//        try? moc.save()
//    }
//    
//    func addTask(moc: NSManagedObjectContext, taskName: String, done: Bool, dueDate: Date?, priority: Int16) {
//        let task = TaskEntity(context: moc)
//        task.taskName = taskName
//        task.done = done
//        task.dueDate = dueDate
//        task.priority = priority
//    }
    
    func addMockData(moc: NSManagedObjectContext) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        
        addExpense(moc: moc, itemName: "Biscuits", itemAmount: 200, itemQuantity: 1, itemDescription: "Digestive Hobnobs", payee: "SHOPRITE", expenseTotal: 349, currency: "NGN", expenseDate: dateFormatter.date(from: "04-12-2023"), paymentType: "Cash")
        
        addExpense(moc: moc, itemName: "Chocolate", itemAmount: 650, itemQuantity: 2, itemDescription: "Mars Chocolate", payee: "SHOPRITE", expenseTotal: 1300, currency: "NGN", expenseDate: dateFormatter.date(from: "04-12-2023"), paymentType: "Debit Card")
        
        addExpense(moc: moc, itemName: "Canoe Soap", itemAmount: 250, itemQuantity: 2, itemDescription: "Washing Soap", payee: "SHOPRITE", expenseTotal: 500, currency: "NGN", expenseDate: dateFormatter.date(from: "04-12-2023"), paymentType: "Cash")
        
        try? moc.save()
    }
    
    func addExpense(moc: NSManagedObjectContext, itemName: String, itemAmount: Double, itemQuantity: Double, itemDescription: String, payee: String, expenseTotal: Double, currency: String, expenseDate: Date?, paymentType: String) {
        let expense = ExpensesEntity(context: moc)
        
        expense.itemName = itemName
        expense.itemAmount = itemAmount
        expense.itemQuantity = itemQuantity
        expense.itemDescription = itemDescription
        expense.payee = payee
        expense.expenseTotal = expenseTotal
//        expense.dailyTotal = dailyTotal
        expense.currency = currency
        expense.paymentType = paymentType
    }
}

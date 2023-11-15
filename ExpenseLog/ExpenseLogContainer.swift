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
}

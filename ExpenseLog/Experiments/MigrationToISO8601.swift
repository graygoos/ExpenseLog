//
//  MigrationToISO8601.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 17/05/2024.
//

import Foundation

/*
 // function used to migrate existing data to ISO8601 in the app
 func migrateDatesToISO8601() {
     let context = persistentContainer.viewContext
     let fetchRequest: NSFetchRequest<ExpensesEntity> = ExpensesEntity.fetchRequest()
     
     do {
         let expenses = try context.fetch(fetchRequest)
         let isoFormatter = ISO8601DateFormatter()
         isoFormatter.formatOptions = [.withFullDate, .withTime, .withDashSeparatorInDate, .withColonSeparatorInTime]
         
         for expense in expenses {
             if let date = expense.expenseDate {
                  Convert date to ISO8601 formatted string and then back to date
                 let dateString = isoFormatter.string(from: date)
                 if let newDate = isoFormatter.date(from: dateString) {
                     expense.expenseDate = newDate
                 }
             }
         }
         
         try context.save()
         print("Migration to ISO8601 format completed successfully.")
     } catch {
         print("Failed to migrate dates to ISO8601 format: \(error)")
     }
 }
 
 func migrateDatesToISO8601() {
     guard let moc = moc else { return }
     let fetchRequest: NSFetchRequest<ExpensesEntity> = ExpensesEntity.fetchRequest()
     
     do {
         let expenses = try moc.fetch(fetchRequest)
         for expense in expenses {
             if let dateString = expense.expenseDateString {
                 if let date = Date.fromISO8601String(dateString) {
                     expense.expenseDate = date
                 }
             }
         }
         try moc.save()
     } catch {
         print("Error migrating dates: \(error)")
     }
 }
 */

//
//  FilteringHistory.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 02/02/2024.
//

import Foundation

/*
@State private var showModal = false

@SectionedFetchRequest<Date?, ExpensesEntity>(sectionIdentifier: \.expenseDate, sortDescriptors: [])
private var expenses

var body: some View {
//        HStack {
//            Image(systemName: "paperplane.fill")
//        }
    ContentUnavailableView(label: {
        Label("No Expense logged.", systemImage: "calendar.badge.clock")
    }, description: {
        Text("History of logged expenses will be shown here.")
    }, actions: {
    })
    .navigationTitle("History")
    .toolbar {
        ToolbarItem {
            Button(action: {
                self.showModal.toggle()
            }) {
                Image(systemName: "plus")
            }
            .sheet(isPresented: $showModal, onDismiss: {
                print("expenseEntryView dismissed")
            }, content: {
                ExpenseEntryView()
            })
        }
    }
}
*/
/*
@Environment(\.managedObjectContext) var moc

private enum ExpensesSection: String, CaseIterable {
        case yesterday = "Yesterday"
        case last7Days = "Last 7 Days"
        case lastMonth = "Last Month"
        case last3Months = "Last 3 Months"
        case last6Months = "Last 6 Months"
        case last12Months = "Last 12 Months"
        case olderThan12Months = "Older Than 12 Months"
    }

    private var fetchRequest: FetchRequest<ExpensesEntity> {
        FetchRequest<ExpensesEntity>(
            entity: ExpensesEntity.entity(),
            sortDescriptors: [NSSortDescriptor(keyPath: \ExpensesEntity.expenseDate, ascending: false)]
        )
    }

    var body: some View {
        List {
            ForEach(Section.allCases, id: \.self) { section in
                Section(rawValue: "", header: Text(section.rawValue)) {
                    ForEach(expenses(for: section), id: \.self) { expense in
                        Text("Amount: \(expense.expenseTotal ?? 0.0, specifier: "%.2f") - Date: \(expense.expenseDate, formatter: dateFormatter)")
                    }
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
    }

    private func expenses(for section: ExpensesSection) -> [ExpensesEntity] {
        let predicate = getDatePredicate(for: section)
        return fetchRequest.wrappedValue.filter { predicate.evaluate(with: $0) }
    }

    private func getDatePredicate(for section: ExpensesSection) -> NSPredicate {
        let currentDate = Date()
        switch section {
        case .yesterday:
            return NSPredicate(format: "date >= %@ AND date < %@", currentDate.startOfDay.addingTimeInterval(-1) as CVarArg, currentDate.startOfDay as CVarArg)
        case .last7Days:
            return NSPredicate(format: "date >= %@", currentDate.startOfDay.addingTimeInterval(-7 * 24 * 3600) as CVarArg)
        case .lastMonth:
            return NSPredicate(format: "date >= %@ AND date < %@", currentDate.startOfDay.addingTimeInterval(-30 * 24 * 3600) as CVarArg, currentDate.startOfDay as CVarArg)
        case .last3Months:
            return NSPredicate(format: "date >= %@", currentDate.startOfDay.addingTimeInterval(-3 * 30 * 24 * 3600) as CVarArg)
        case .last6Months:
            return NSPredicate(format: "date >= %@", currentDate.startOfDay.addingTimeInterval(-6 * 30 * 24 * 3600) as CVarArg)
        case .last12Months:
            return NSPredicate(format: "date >= %@", currentDate.startOfDay.addingTimeInterval(-12 * 30 * 24 * 3600) as CVarArg)
        case .olderThan12Months:
            return NSPredicate(format: "date < %@", currentDate.startOfDay.addingTimeInterval(-12 * 30 * 24 * 3600) as CVarArg)
        }
    }

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
*/

/*
@State private var selectedFilter: HistoryFilter = .last7Days

//    @FetchRequest<ExpensesEntity>(
//        sortDescriptors: [],
//            predicate: NSPredicate(format: "%K >= %@ AND %K <= %@", argumentArray: [#keyPath(ExpensesEntity.expenseDate), Date().startDay as NSDate, #keyPath(ExpensesEntity.expenseDate), Date().endDayOf as NSDate]),
//            animation: .default
//        ) private var expenses

private var fetchRequest: FetchRequest<ExpensesEntity> {
        let predicate = getDatePredicate(for: selectedFilter)
        return FetchRequest<ExpensesEntity>(
            entity: ExpensesEntity.entity(),
            sortDescriptors: [NSSortDescriptor(keyPath: \ExpensesEntity.expenseDate, ascending: false)],
            predicate: predicate
        )
    }

@State private var showModal = false

var body: some View {
    NavigationStack {
        VStack {
                    // Add a picker to select date range filter
                    Picker("Date Range", selection: $selectedFilter) {
                        ForEach(HistoryFilter.allCases, id: \.self) { filter in
                            Text(filter.rawValue)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    
                    // Display the list of expenses
//                        List {
//                            ForEach(fetchRequest.wrappedValue, id: \.self) { expense in
//                                Text("Amount: \(expense.expenseTotal ?? 0.0) - Date: \(expense.expenseDate, formatter: dateFormatter)")
//                            }
//                        }
                }
        
        ContentUnavailableView(label: {
            Label("No Expense logged.", systemImage: "calendar.badge.clock")
        }, description: {
            Text("History of logged expenses will be shown here.")
        }, actions: {
        })
        .navigationTitle("History")
        .toolbar {
            ToolbarItem {
                Button(action: {
                    self.showModal.toggle()
                }) {
                    Image(systemName: "plus")
                }
                .sheet(isPresented: $showModal, onDismiss: {
                    print("expenseEntryView dismissed")
                }, content: {
                    ExpenseEntryView()
                })
            }
        }
    }
}

private let dateFormatter: DateFormatter = {
       let formatter = DateFormatter()
       formatter.dateStyle = .short
       formatter.timeStyle = .short
       return formatter
   }()

private func getDatePredicate(for filter: HistoryFilter) -> NSPredicate {
    let currentDate = Date()
    switch filter {
    case .yesterday:
        return NSPredicate(format: "date >= %@ AND date < %@", currentDate.startOfDay.addingTimeInterval(-1) as CVarArg, currentDate as CVarArg)
    case .last7Days:
        return NSPredicate(format: "date >= %@", currentDate.startOfDay.addingTimeInterval(-7 * 24 * 3600) as CVarArg)
    case .lastMonth:
        return NSPredicate(format: "date >= %@ AND date < %@", currentDate.startOfDay.addingTimeInterval(-30 * 24 * 3600) as CVarArg, currentDate as CVarArg)
    case .last3Months:
        return NSPredicate(format: "date >= %@", currentDate.startOfDay.addingTimeInterval(-3 * 30 * 24 * 3600) as CVarArg)
    case .last6Months:
        return NSPredicate(format: "date >= %@", currentDate.startOfDay.addingTimeInterval(-6 * 30 * 24 * 3600) as CVarArg)
    case .last12Months:
        return NSPredicate(format: "date >= %@", currentDate.startOfDay.addingTimeInterval(-12 * 30 * 24 * 3600) as CVarArg)
    case .olderThan12Months:
        return NSPredicate(format: "date < %@", currentDate.startOfDay.addingTimeInterval(-12 * 30 * 24 * 3600) as CVarArg)
    }
}
*/



//enum HistoryFilter: String, CaseIterable {
//    case yesterday = "Yesterday"
//    case last7Days = "Last 7 Days"
//    case lastMonth = "Last Month"
//    case last3Months = "Last 3 Months"
//    case last6Months = "Last 6 Months"
//    case last12Months = "Last 12 Months"
//    case olderThan12Months = "Older than 12 Months"
//}

/*
 private func isWithinDays(_ date: Date?, days: Int) -> Bool {
     guard let date = date else { return false }
     let calendar = Calendar.current
     let startDate = calendar.date(byAdding: .day, value: -days, to: Date())!
     return date >= startDate && date <= Date()
 }
 
 private func isOverDays(_ date: Date?, days: Int) -> Bool {
     guard let date = date else { return false }
     let calendar = Calendar.current
     let startDate = calendar.date(byAdding: .day, value: -days, to: Date())!
     return date < startDate
 }
 /*
 private func isYesterday(_ date: Date) -> Bool {
     let calendar = Calendar.current
     return calendar.isDateInYesterday(date)
 }
 
 private func isLast7Days(_ date: Date) -> Bool {
     let calendar = Calendar.current
     let startDate = calendar.date(byAdding: .day, value: -6, to: Date())!
     return date >= startDate && date <= Date()
 }
 
 private func isLastMonth(_ date: Date) -> Bool {
     let calendar = Calendar.current
     let startDate = calendar.date(byAdding: .month, value: -1, to: calendar.startOfDay(for: Date()))!
     let endDate = calendar.date(byAdding: .second, value: -2, to: calendar.date(byAdding: .month, value: 1, to: startDate)!)!
     return date >= startDate && date <= endDate
 }
 
 private func isLast3Months(_ date: Date) -> Bool {
     return isLastMonths(date, months: 3)
 }
 
 private func isLast6Months(_ date: Date) -> Bool {
     return isLastMonths(date, months: 6)
 }
 
 private func isLast12Months(_ date: Date) -> Bool {
     return isLastMonths(date, months: 12)
 }
 
 private func isOver12Months(_ date: Date) -> Bool {
     let calendar = Calendar.current
     let startDate = calendar.date(byAdding: .year, value: -1, to: Date())!
     return date > startDate
 }
 
 private func isLastMonths(_ date: Date, months: Int) -> Bool {
     let calendar = Calendar.current
     let startDate = calendar.date(byAdding: .month, value: -months, to: calendar.startOfDay(for: Date()))!
     let endDate = calendar.date(byAdding: .second, value: -1, to: calendar.date(byAdding: .month, value: 1, to: startDate)!)!
     return date >= startDate && date <= endDate
     
 }
 */
 private func expensesForDate(_ date: Date) -> [ExpensesEntity] {
     let calendar = Calendar.current
     return expenses.filter { calendar.isDate($0.expenseDate!, inSameDayAs: date) }
 }

 */

/*
 
 // Represent a group of expenses for a particular date
 struct GroupedExpense: Identifiable {
     let id = UUID()
     let date: Date
     let expenses: [ExpensesEntity]
 }

 struct HistoryTabView: View {
     @Environment(\.managedObjectContext) var moc
     
     @FetchRequest(entity: ExpensesEntity.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \ExpensesEntity.expenseDate, ascending: false)], animation: .default) var expenses: FetchedResults<ExpensesEntity>
     
     private var groupedExpenses: [GroupedExpense] {
         let groupedDictionary = Dictionary(grouping: expenses) { (expense) -> Date in
             guard let date = expense.expenseDate else {
                 return Date()
             }
             return Calendar.current.startOfDay(for: date)
         }
         
         return groupedDictionary.map { (key, value) in
             return GroupedExpense(date: key, expenses: value)
         }.sorted(by: { $0.date > $1.date })
     }
     
     var body: some View {
         NavigationStack {
             List {
                 ForEach(groupedExpenses, id: \.date) { groupedExpense in
                     Section(header: Text(groupedExpense.date.description)) {
                         ForEach(groupedExpense.expenses, id: \.self) { expense in
                             NavigationLink(destination: ExpenseListView(date: expense.expenseDate)) {
                                 Text(expense.expenseDate?.description ?? "Unknown Date")
                             }
                             
                         }
                     }
                     
                 }
             }
             .navigationTitle("History")
         }
     }
     
     // Filter expenses based on date
     private func expenses(for predicate: NSPredicate) -> [ExpensesEntity] {
         return expenses.filter { predicate.evaluate(with: $0)}
     }
     
     // Create a predicate for expenses in the last N days
     private func predicate(forLastNDays days: Int) -> NSPredicate {
         let calendar = Calendar.current
         let now = Date()
         let startDate = calendar.date(byAdding: .day, value: -days, to: now)!
         let endDate = now
         
         return NSPredicate(format: "expenseDate >= %@ AND expenseDate <= %@", startDate as NSDate, endDate as NSDate)
     }
 }
 
 */

//
//  ExpenseEntryView.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 15/11/2023.
//

import SwiftUI

struct ExpenseEntryView: View {
//    let expense: ExpensesEntity?
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var itemName = ""
    @State private var itemAmount = 0.00
    @State private var itemDescription = ""
    @State private var itemUnit = "Unknown"
    @State private var payee = ""
    @State private var expenseLocation = ""
    @State private var itemQuantity = 1
    @State private var paymentType = "Cash"
    @State private var expenseDate = Date()
    @State private var recurringExpense = false
    @State private var isBudgeted = false
    @State private var expenseFrequency = "One-time"
    @State private var currency = "NGN"
    
    var itemUnits = ["Unknown", "Pack", "Tin", "Carton", "Bag", "Box", "Bottles", "Jar", "Can", "Piece", "Case", "Bulk Container", "Pouch", "Blister Pack", "Wrapper", "Foil", "Container", "Envelope", "Cellophane/Plastic wrap", "Bushel", "Other"]
    
    var paymentMethod = ["Cash", "Credit Card", "Debit Card", "Cheque", "Electronic Funds Transfer", "Cryptocurrency"]
    
    var frequency = ["Hourly", "Daily", "Weekly", "Monthly", "Quarterly", "Annually", "One-time"]
    
//    var allCurrencies = [
    let allCurrencies: [String] = {
        let locales = Locale.availableIdentifiers.map { Locale(identifier: $0) }
        return locales.compactMap { $0.currency?.identifier }
    }()
    
    @State private var showModal = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Item purchased") {
                    TextField("Item name", text: $itemName)
                }
                Section("Enter item amount") {
                    TextField("Item Amount", value: $itemAmount, format: .currency(code: Locale.current.currency?.identifier ?? "NGN"))
                        .keyboardType(.decimalPad)
//                    HStack {
//                        CurrencyPicker()
//                    }
                    Picker("Currency", selection: $currency) {
                        ForEach(allCurrencies, id: \.self) { unit in
                            Text(unit)
                        }
                    }
                }
                Section {
                    Picker("Payment Method", selection: $paymentType) {
                        ForEach(paymentMethod, id: \.self) { unit in
                            Text(unit)
                        }
                    }
                    Toggle("Recurring expense", isOn: $recurringExpense)
                    Toggle("Budgeted", isOn: $isBudgeted)
                }
                Section("Item quantity") {
                    Stepper("Quantity: \(itemQuantity)", value: $itemQuantity, in: 1...Int.max)
                    Picker("Item Unit", selection: $itemUnit) {
                        ForEach(itemUnits, id: \.self) { unit in
                            Text(unit)
                        }
                    }
                }
                Section("vendor/payee/recipient") {
                    TextField("Vendor", text: $payee)
                }
                Section("location") {
                    VStack {
                        HStack { // V2
                            TextField("Location", text: $expenseLocation)
    //                        Image(systemName: "mappin.and.ellipse")
                            Button(action: {}) {
                                Image(systemName: "mappin.and.ellipse")
                            }
                        }
                    }
                }
                Section("Item description") {
                    TextField("Description", text: $itemDescription, axis: .vertical)
                        .textFieldStyle(.plain)
                        .lineLimit(5, reservesSpace: true)
                }
                Section {
                    Picker("Expense Frequency", selection: $expenseFrequency) {
                        ForEach(frequency, id: \.self) { item in
                            Text(item)
                        }
                    }
                }
                Section("Expense date") {
                    DatePicker("Date", selection: $expenseDate)
                }
                /*
                Section {
                    Button(action: {
                        print(itemUnits.count)
                        print(paymentMethod.count)
                        self.showModal.toggle()
//                        dismiss()
                    }) {
                        Text("Add another expense")
                    }
                    .frame(maxWidth: .infinity)
//                    .buttonStyle(.borderedProminent)
                }*/
            }
            .toolbar {
                Button(action: {
                    print("cancel button tapped")
                    dismiss()
                }) {
                    Text("Cancel")
                }
                Spacer()
                
                Button(action: {
                    let expense = ExpensesEntity(context: moc)
                    expense.itemName = itemName
                    expense.itemUnit = itemUnit
//                    expense.itemAmount = itemAmount
                    expense.itemDescription = itemDescription
                    expense.paymentType = paymentType
                    
                    try? moc.save()
                    
                    print("save button tapped")
                    dismiss()
                }) {
                    Text("Add")
                }
                .navigationTitle("Enter expense")
            }
        }
    }
}

#Preview {
    ExpenseEntryView()
}


/*
 Questions:
 Item unit - navigation
 toggles - yes/no
 default parameters, add others from settings tab,
 */

/*
 struct Expense {
     expenseID: uuid                        (system inputs - generates)
    ✅ itemAmount: Double    **             // (** fields must be filled)
     ✅itemName: String     **
     ✅quantity: Double
     ✅unit: String
     ✅itemDescription: String?            (notes)
     ✅store/vendor/payee/recipient: String
     ✅expenseLocation: String?     // (location data, expense location/vendor/provider)
     ✅expenseDate: Date
     timeEntered: Date                     (system inputs - generates)
     // total: Double
     ✅currencySymbol:             // (automatically assign currency from user location?)
     ✅paymentMethod: PaymentMethod
 }


 struct Expense {
     expenseID: uuid
     itemAmount: Double
     itemName: String
     quantity: Double
     unit: String
     itemDescription: String?
     store/payee/recipient: String
     expenseLocation: String?
     expenseDate: Date
     timeEntered: Date
     // total: Double
     currencySymbol:
     expenseType: ExpenseType
     expenseReceipt: Image?                 (Binary Data)
     paymentMethod: PaymentMethod
     recurringExpense: Bool
     expenseFrequency: ExpenseFrequency                recurringFrequency
     inBudget: Bool
 }
 
 struct ExpenseType {    (ExpenseCategory)
     fixed
     variable
     discretionary
 }


 enum ExpenseFrequency {
     hourly
     daily
     weekly
     monthly
     quarterly
     annually
     one-time
 }


 struct ExpenseSchedule {
     startTime: Date
     endTime: Date
     interval: Int = 1
     ifHourly: startTime, endTime
     limitDays: Day
 }


 enum Day {
     sunday
     monday
     tuesday
     wednesday
     thursday
     friday
     saturday
 }


 FixedExpense {
     Rent or Mortgage Payment
     Property Taxes
     Home Insurance
     Auto Loan Payment
     Student Loan Payment
     Health Insurance Premium
     Life Insurance Premium
     Cable or Satellite TV Subscription
     Internet Subscription
     Mobile Phone Plan
     Gym Membership
     Childcare Costs
     Home Maintenance
     Association Dues (e.g., HOA fees)
     Retirement Contributions (e.g., 401(k) contributions)
     Loan Payments (e.g., personal loans)
     Professional Memberships
     Magazine or Newspaper Subscriptions
     Public Transportation Passes (if purchased monthly)
 }


 VariableExpense {
     Groceries
     Utility Bills (electricity, gas, water)
     Transportation (fuel, public transit)
     Dining Out
     Entertainment (movies, concerts)
     Clothing and Apparel
     Personal Care (toiletries, haircuts)
     Home Supplies (cleaning, toiletries)
     Gifts and Presents
     Pet Expenses (food, grooming)
     Health and Wellness (prescriptions, supplements)
     Travel Expenses (hotel, airfare)
     Hobbies and Activities
     Electronics and Gadgets
     Car Maintenance and Repairs
     Home Decor
     School Supplies
     Miscellaneous Expenses
 }


 DiscretionaryExpense {
     Vacations
     Fine Dining
     Luxury Items (e.g., designer clothing, jewelry)
     Spa and Wellness Retreats
     Theater or Event Tickets
     Recreational Activities (e.g., golf, skiing)
     Art and Collectibles
     Electronic Gadgets (e.g., high-end smartphones)
     Gaming Consoles and Video Games
     High-End Cars and Accessories
     Excessive Dining Out
     Subscription Boxes (e.g., luxury beauty products)
     Charitable Donations
     Private Club Memberships
     Designer Furniture and Home Decor
     Exotic or Luxury Travel
     Personal Stylist or Shopper Services
     Collector's Items (e.g., rare stamps, coins)
 }


 enum PaymentMethod {
     case cash
     case creditCard
     case debitCard
     case check
     case electronicFundsTransfer
 }


 struct Budget {
     
 }
 */

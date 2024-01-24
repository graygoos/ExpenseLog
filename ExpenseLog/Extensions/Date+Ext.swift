//
//  Date+Ext.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 24/01/2024.
//

import Foundation

extension Date {
    var startDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    var endDayOf: Date {
        return Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: self)!
    }
}

//
//  Date+Ext.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 24/01/2024.
//

import Foundation

extension Date {
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    var endDayOf: Date {
        return Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: self)!
    }
    
    var formatted: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
//        dateFormatter.timeZone = TimeZone.current
//        dateFormatter.timeZone = TimeZone.autoupdatingCurrent // see which is more optimal
        
        return dateFormatter.string(from: self)
    }
    
    var formattedDay: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
//        dateFormatter.timeZone = TimeZone.current
//        dateFormatter.timeZone = TimeZone.autoupdatingCurrent // see which is more optimal
        
        return dateFormatter.string(from: self)
    }
    
}

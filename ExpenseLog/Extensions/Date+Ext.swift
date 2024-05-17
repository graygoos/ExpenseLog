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
        
        return dateFormatter.string(from: self)
    }
    
    var formattedDay: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        return dateFormatter.string(from: self)
    }
    
    static func fromISO8601String(_ iso8601String: String) -> Date? {
        let isoFormatter = ISO8601DateFormatter()
        return isoFormatter.date(from: iso8601String)
    }
    
    // Format dates to ISO8601 when logging or displaying them
    func toISO8601String() -> String {
        let formatter = ISO8601DateFormatter()
//        formatter.formatOptions = [.withFullDate, .withTime, .withDashSeparatorInDate, .withColonSeparatorInTime, .withTimeZone]
        formatter.formatOptions = [.withInternetDateTime]
        return formatter.string(from: self)
    }
    
    func toLocalTimeString(timeZone: TimeZone = .current) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.timeZone = timeZone
        return dateFormatter.string(from: self)
    }
    
}




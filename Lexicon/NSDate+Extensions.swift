//
//  NSDate+Extensions.swift
//  PABK
//
//

import Foundation

extension NSDate {
    private static let dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en-US")
        formatter.dateFormat = "dd.MM.yyyy"

        return formatter
    }()
    
    private static let dayEncoder: DateFormatter = {
        let encoder = DateFormatter()
        encoder.locale = Locale(identifier: "en-US")
        encoder.dateFormat = "yyyy-MM-dd"
        
        return encoder
    }()
    
    func localizedDayString() -> String {
        return NSDate.dayFormatter.string(from: self as Date)
    }
    

    
    func encodeDayWithTimezone() -> String {
        return NSDate.dayEncoder.string(from: self as Date)
    }
    
    func toISODate() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en-US")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        return formatter.string(from: self as Date)
    }
}

//
//  String+Extensions.swift
//  NextLife
//
//  Created by Minh on 7/19/16.
//  Copyright © 2016 ZENTITY a.s. All rights reserved.
//

import UIKit

extension String {    
    fileprivate static let dateParser: DateFormatter = {
        let parser = DateFormatter()
        parser.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        return parser
    }()
    
    fileprivate static let dateParserWithMillis: DateFormatter = {
        let parser = DateFormatter()
        parser.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        return parser
    }()
    
    func parseDate(_ format: String? = nil) -> Date? {
        if let format = format {
            let parser = DateFormatter()
            parser.dateFormat = format
            return parser.date(from: self)
        } else if let date = String.dateParser.date(from: self) {
            return date
        } else if let date = String.dateParserWithMillis.date(from: self) {
            return date
        } else {
            log.error("Invalid date format", error: nil)
            return nil
        }
    }
    
    func toDateString(_ format: String) -> String? {
        if let date = self.parseDate(format) {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.YYYY"
            return formatter.string(from: date)
        }
        return nil
    }
}

//
//  NSDate+Utils.swift
//  SYNUtils
//
//  Created by John Hurliman on 6/23/15.
//  Copyright (c) 2015 Syntertainment. All rights reserved.
//

import Foundation

extension NSDate {
    public class func currentTZOffset() -> NSTimeInterval {
        return Double(NSTimeZone.localTimeZone().secondsFromGMT) / 60.0
    }
    
    // MARK: - Standard Date String Conversions
    
    struct DateFormatters {
        static var isoFormatter: NSDateFormatter = {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z"
            formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
            formatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
            formatter.calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierISO8601)!
            return formatter
        }()
        
        static var rfc3339Formatter: NSDateFormatter = {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZ"
            formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
            formatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
            formatter.calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierISO8601)!
            return formatter
        }()
    }
    
    public convenience init?(dateString: String) {
        var dateString = dateString
        let initialLength = dateString.length
        if initialLength > 20 {
            // Remove colon in the timezone since iOS 4+ NSDateFormatter can't handle them
            dateString = dateString.stringByReplacingOccurrencesOfString(
                ":", withString: "", options: .LiteralSearch, range: dateString.range(startOffset: 20))
        }
        
        // Try RFC 3339 first
        if let d = DateFormatters.rfc3339Formatter.dateFromString(dateString) {
            self.init(timeInterval: 0, sinceDate: d)
            return
        }
        
        // Try ISO 8601 next
        if let d = DateFormatters.isoFormatter.dateFromString(dateString) {
            self.init(timeInterval: 0, sinceDate: d)
            return
        }
        
        self.init(timeInterval: 0, sinceDate: NSDate())
        return nil
    }
    
    public func toISOString() -> String {
        return DateFormatters.isoFormatter.stringFromDate(self)
    }
    
    public func toRFC3339String() -> String {
        return DateFormatters.rfc3339Formatter.stringFromDate(self)
    }
    
    // MARK: - UNIX Timestamps
    
    public func unixTimestamp() -> Int64 {
        return Int64(self.timeIntervalSince1970)
    }
    
    // MARK: - Human-Friendly Conversions
    
    public func shortRelativeString(pastDate: NSDate) -> String {
        let now = NSDate()
        
        let referenceTime = now.timeIntervalSinceDate(pastDate)
        let seconds       = round(fabs(referenceTime));
        let minutes       = round(seconds / 60.0);
        let hours         = round(minutes / 60.0);
        let days          = round(hours / 24.0);
        let years         = round(days / 365.0);
        
        if (seconds < 45) {
            return "now";
        } else if (minutes == 1) {
            return "1m";
        } else if (minutes < 45) {
            return "\(Int(minutes))m"
        } else if (hours == 1) {
            return "1h";
        } else if (hours < 22) {
            return "\(Int(hours))h"
        } else if (days == 1) {
            return "1d";
        } else if (days < 7) {
            return "\(Int(days))d"
        } else if (days < 14) {
            return "1w";
        } else if (days < 345) {
            return "\(Int(round(days / 7.0)))w"
        } else if (years == 1) {
            return "1y";
        } else {
            return "\(Int(years))y"
        }
    }
    
    // MARK: - Date Arithmetic
    
    public func midnight() -> NSDate {
        let preservedComponents: NSCalendarUnit =
            .CalendarUnitYear | .CalendarUnitMonth | .CalendarUnitDay |
            .CalendarUnitHour | .CalendarUnitMinute | .CalendarUnitSecond
        
        let components = NSCalendar.currentCalendar().components(preservedComponents, fromDate: self)
        components.hour = 0
        components.minute = 0
        components.second = 0
        
        return NSCalendar.currentCalendar().dateFromComponents(components)!
    }
    
    
}

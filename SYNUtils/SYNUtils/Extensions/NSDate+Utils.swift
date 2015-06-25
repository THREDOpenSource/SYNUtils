//
//  NSDate+Utils.swift
//  SYNUtils
//
//  Created by John Hurliman on 6/23/15.
//  Copyright (c) 2015 Syntertainment. All rights reserved.
//

import Foundation

extension NSDate: Comparable {
    /// Returns the current system local timezone as the number of seconds
    /// offset from GMT.
    ///
    /// :returns: Example: -25200 seconds for Pacific Daylight Time
    public class func currentTZOffset() -> NSTimeInterval {
        return NSTimeInterval(NSTimeZone.localTimeZone().secondsFromGMT)
    }
    
    /// Returns the current system local timezone as the number of minutes
    /// offset from GMT.
    /// :returns: Example: -420 minutes for Pacific Daylight Time
    public class func currentTZOffsetMinutes() -> Int {
        return Int(currentTZOffset() / 60.0)
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
    
    /// Initialize NSDate from a date string in either RFC 3339 or ISO 8601
    /// format.
    ///
    /// :param: dateString String representation of a date and time. Example:
    ///   "2015-06-25T22:28:19.690Z"
    public convenience init?(dateString: String) {
        var dateString = dateString
        let initialLength = dateString.length
        if initialLength > 20 {
            // Remove colon in the timezone since iOS 4+ NSDateFormatter can't handle them
            dateString = dateString.replace(":", withString: "", range: (20..<initialLength))
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
    
    /// Returns this date as an ISO 8601 string.
    ///
    /// :returns: ISO 8601 formatted string
    public func toISOString() -> String {
        return DateFormatters.isoFormatter.stringFromDate(self)
    }
    
    /// Returns this date as an RFC 3339 string.
    ///
    /// :returns: RFC 3339 formatted string
    public func toRFC3339String() -> String {
        return DateFormatters.rfc3339Formatter.stringFromDate(self)
    }
    
    // MARK: - UNIX Timestamps
    
    /// Returns this date as a UNIX timestamp (number of whole seconds passed
    /// since the UNIX epoch).
    ///
    /// :returns: 64-bit integer timestamp
    public func unixTimestamp() -> Int64 {
        return Int64(self.timeIntervalSince1970)
    }
    
    // MARK: - Human-Friendly Conversions
    
    /// Returns the difference between this date and another date as a short
    /// human-friendly string. Examples: "now", "3m", "5h", "1w", "2015y".
    ///
    /// :param: otherDate Other date to compare this date against. The absolute
    ///   difference between the two dates is used.
    /// :returns: A short string representation of the time difference between
    ///   the two dates
    public func shortRelativeString(otherDate: NSDate) -> String {
        let now = NSDate()
        
        let referenceTime = now.timeIntervalSinceDate(otherDate)
        let seconds       = round(fabs(referenceTime))
        let minutes       = round(seconds / 60.0)
        let hours         = round(minutes / 60.0)
        let days          = round(hours / 24.0)
        let years         = round(days / 365.0)
        
        if (seconds < 45) {
            return "now"
        } else if (minutes == 1) {
            return "1m"
        } else if (minutes < 45) {
            return "\(Int(minutes))m"
        } else if (hours == 1) {
            return "1h"
        } else if (hours < 22) {
            return "\(Int(hours))h"
        } else if (days == 1) {
            return "1d"
        } else if (days < 7) {
            return "\(Int(days))d"
        } else if (days < 14) {
            return "1w"
        } else if (days < 345) {
            return "\(Int(round(days / 7.0)))w"
        } else if (years == 1) {
            return "1y"
        } else {
            return "\(Int(years))y"
        }
    }
    
    // MARK: - Date Arithmetic
    
    /// Returns an NSDate for midnight of the same day as this date.
    ///
    /// :returns: NSDate at midnight
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
    
    /// Returns a new date by adding seconds to the current date.
    public func addSeconds(seconds: Int) -> NSDate {
        return NSCalendar.currentCalendar().dateByAddingUnit(
            .CalendarUnitSecond, value: seconds, toDate: self, options: nil)!
    }
    
    /// Returns a new date by adding minutes to the current date.
    public func addMinutes(minutes: Int) -> NSDate {
        return NSCalendar.currentCalendar().dateByAddingUnit(
            .CalendarUnitMinute, value: minutes, toDate: self, options: nil)!
    }
    
    /// Returns a new date by adding hours to the current date.
    public func addHours(hours: Int) -> NSDate {
        return NSCalendar.currentCalendar().dateByAddingUnit(
            .CalendarUnitHour, value: hours, toDate: self, options: nil)!
    }
    
    /// Returns a new date by adding days to the current date.
    public func addDays(days: Int) -> NSDate {
        return NSCalendar.currentCalendar().dateByAddingUnit(
            .CalendarUnitDay, value: days, toDate: self, options: nil)!
    }
    
    /// Returns a new date by adding weeks to the current date.
    public func addWeeks(weeks: Int) -> NSDate {
        return NSCalendar.currentCalendar().dateByAddingUnit(
            .CalendarUnitWeekOfMonth, value: weeks, toDate: self, options: nil)!
    }
    
    /// Returns a new date by adding months to the current date.
    public func addMonths(months: Int) -> NSDate {
        return NSCalendar.currentCalendar().dateByAddingUnit(
            .CalendarUnitMonth, value: months, toDate: self, options: nil)!
    }
    
    /// Returns a new date by adding years to the current date.
    public func addYears(years: Int) -> NSDate {
        return NSCalendar.currentCalendar().dateByAddingUnit(
            .CalendarUnitYear, value: years, toDate: self, options: nil)!
    }
    
    // MARK: - Comparison
    
    /// Test if a given date occurs after this date.
    ///
    /// :param: date Date to test against this date
    /// :returns: True if the given date is ahead of this date, otherwise false
    ///   if it is equal to or behind this date.
    public func isAfter(date: NSDate) -> Bool {
        return compare(date) == .OrderedDescending
    }
    
    /// Test if a given date occurs before this date.
    ///
    /// :param: date Date to test against this date
    /// :returns: True if the given date is behind this date, otherwise false
    ///   if it is equal to or ahead of this date.
    public func isBefore(date: NSDate) -> Bool {
        return compare(date) == .OrderedAscending
    }
    
    // MARK: - Getters
    
    /// Year component
    public var year: Int { return getComponent(.CalendarUnitYear) }
    /// Month component
    public var month: Int { return getComponent(.CalendarUnitMonth) }
    /// Week component
    public var weekOfMonth: Int { return getComponent(.CalendarUnitWeekOfMonth) }
    /// Day of Week component
    public var weekday: Int { return getComponent(.CalendarUnitWeekday) }
    /// Day of Year component
    public var days: Int { return getComponent(.CalendarUnitDay) }
    /// Hours component
    public var hours: Int { return getComponent(.CalendarUnitHour) }
    /// Minutes component
    public var minutes: Int { return getComponent(.CalendarUnitMinute) }
    /// Seconds component
    public var seconds: Int { return getComponent(.CalendarUnitSecond) }
    
    func getComponent(component: NSCalendarUnit) -> Int {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(component, fromDate: self)
        return components.valueForComponent(component)
    }
}

public func +(date: NSDate, timeInterval: NSTimeInterval) -> NSDate {
    return date.dateByAddingTimeInterval(timeInterval)
}

public func -(date: NSDate, timeInterval: NSTimeInterval) -> NSDate {
    return date.dateByAddingTimeInterval(-timeInterval)
}

public func +=(inout date: NSDate, timeInterval: Double) {
    date = date + timeInterval
}

public func -=(inout date: NSDate, timeInterval: Double) {
    date = date - timeInterval
}

public func -(lhs: NSDate, rhs: NSDate) -> NSTimeInterval {
    return lhs.timeIntervalSinceDate(rhs)
}

public func ==(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == .OrderedSame
}

public func <(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == .OrderedAscending
}

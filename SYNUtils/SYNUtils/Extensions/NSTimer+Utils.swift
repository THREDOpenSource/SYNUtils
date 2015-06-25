//
//  NSTimer+Utils.swift
//  SYNUtils
//
//  Created by John Hurliman on 6/23/15.
//  Copyright (c) 2015 Syntertainment. All rights reserved.
//

import Foundation

extension NSTimer {
    public typealias TimerCallback = NSTimer! -> Void
    
    /// Schedule a function to run once after the specified delay.
    ///
    /// :param: delay Number of seconds to wait before running the function
    /// :param: handler Function to run
    /// :returns: The newly created timer associated with this execution
    public class func schedule(delay afterDelay: NSTimeInterval, handler: TimerCallback) -> NSTimer {
        let fireDate = afterDelay + CFAbsoluteTimeGetCurrent()
        let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, 0, 0, 0, handler)
        CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, kCFRunLoopCommonModes)
        return timer
    }
    
    /// Schedule a function to run continuously with the specified interval.
    ///
    /// :param: repeatInterval Number of seconds to wait before running the
    ///   function the first time, and in between each successive run
    /// :param: handler Function to return
    /// :returns: The newly created timer associated with this execution
    public class func schedule(repeatInterval interval: NSTimeInterval, handler: TimerCallback) -> NSTimer {
        let fireDate = interval + CFAbsoluteTimeGetCurrent()
        let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, interval, 0, 0, handler)
        CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, kCFRunLoopCommonModes)
        return timer
    }
}

//
//  NSTimer+Utils.swift
//  SYNUtils
//
//  Created by John Hurliman on 6/23/15.
//  Copyright (c) 2015 Syntertainment. All rights reserved.
//

import Foundation

public enum BackoffStrategy {
    case Exponential
    case Fibonacci
}

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

extension NSTimer {
    public typealias SuccessCallback = Bool -> Void
    public typealias AsyncCallback = SuccessCallback -> Void
    
    /// Run the given callback immediately. If the callback calls its completion
    /// handler with a false value, the callback will be scheduled to run again
    /// in the future using the given delay and backoff strategy settings. This
    /// process will repeat each time the completion handler is called, until it
    /// is called with a true value.
    ///
    ///   NSTimer.tryWithBackoff(.Fibonacci, 0.5, 30.0) {
    ///       (done: Bool -> Void) in
    ///       // Do work, then call done with success/failure
    ///       done(true)
    ///   }
    ///
    /// :param: strategy Backoff strategy. Exponential and Fibonacci backoff are
    ///   currently supported. Both strategies incorporate up to 10% random
    ///   jitter as well
    /// :param: firstDelay Starting delay, after the callback has failed once
    /// :param: maxDelay Upper limit on the delay between callbacks
    /// :param: callback Callback to run immediately and again after each
    ///   failure
    public class func tryWithBackoff(
        strategy: BackoffStrategy,
        firstDelay: NSTimeInterval,
        maxDelay: NSTimeInterval,
        callback: AsyncCallback)
    {
        // Run the callback immediately
        callback {
            (success: Bool) in
            if success { return }
            
            // Create the timer
            let timerInfo = BackoffTimerInfo(strategy: strategy, delay: firstDelay,
                nextDelay: firstDelay, maxDelay: maxDelay, callback: callback)
            NSTimer.scheduledTimerWithTimeInterval(firstDelay, target: timerInfo,
                selector: "timerDidFire:", userInfo: timerInfo, repeats: false)
        }
    }
    
    private class BackoffTimerInfo: NSObject {
        let strategy: BackoffStrategy
        let delay: NSTimeInterval
        let nextDelay: NSTimeInterval
        let maxDelay: NSTimeInterval
        let callback: AsyncCallback
        
        init(strategy: BackoffStrategy, delay: NSTimeInterval, nextDelay: NSTimeInterval, maxDelay: NSTimeInterval, callback: AsyncCallback) {
            self.strategy = strategy
            self.delay = delay
            self.nextDelay = nextDelay
            self.maxDelay = maxDelay
            self.callback = callback
        }
        
        @objc
        func timerDidFire(timer: NSTimer!) {
            let this = self
            let timerInfo = timer.userInfo as! BackoffTimerInfo
            
            timerInfo.callback {
                (success: Bool) in
                if success { return }
                
                var delay: NSTimeInterval
                var nextDelay: NSTimeInterval
                
                switch (timerInfo.strategy) {
                    case .Exponential:
                        delay = timerInfo.delay * 2.0
                        nextDelay = delay
                        break;
                    case .Fibonacci:
                        delay = timerInfo.nextDelay
                        nextDelay = timerInfo.nextDelay + timerInfo.delay
                        break;
                }
                
                let userInfo = BackoffTimerInfo(strategy: timerInfo.strategy, delay: delay,
                    nextDelay: nextDelay, maxDelay: timerInfo.maxDelay, callback: timerInfo.callback)
                
                // Add up to 10% random jitter and cap at max delay
                delay = min(timerInfo.maxDelay, delay + NSTimer.jitter(delay, percent: 0.1))
                NSTimer.scheduledTimerWithTimeInterval(delay, target: this, selector: "timerDidFire:",
                    userInfo: userInfo, repeats: false)
            }
        }
    }
    
    class func jitter(x: Double, percent: Double) -> Double {
        return Double.random(0.0, x) * percent
    }
}

//
//  Double+Utils.swift
//  SYNUtils
//
//  Created by John Hurliman on 6/23/15.
//  Copyright (c) 2015 Syntertainment. All rights reserved.
//

import Foundation

extension Double {
    /// Return the absolute value of this number
    ///
    /// :returns: `fabs(self)`
    public func abs() -> Double {
        return Foundation.fabs(self)
    }
    
    /// Return the square root of this number
    ///
    /// :returns: `sqrt(self)`
    public func sqrt() -> Double {
        return Foundation.sqrt(self)
    }
    
    /// Return this number rounded down to the nearest whole number
    ///
    /// :returns: `floor(self)`
    public func floor() -> Double {
        return Foundation.floor(self)
    }
    
    /// Return this number rounded up to the nearest whole number
    ///
    /// :returns: `ceil(self)`
    public func ceil() -> Double {
        return Foundation.ceil(self)
    }
    
    /// Return this number rounded to the nearest whole number
    ///
    /// :returns: `round(self)`
    public func round() -> Double {
        return Foundation.round(self)
    }
    
    /// Return this value clamped to the closed interval defined by `min` and
    /// `max`
    ///
    /// :param: min Inclusive minimum value
    /// :param: max Inclusive maximum value
    /// :returns: `Swift.max(min, Swift.min(max, self))`
    public func clamp(min: Double, _ max: Double) -> Double {
        return Swift.max(min, Swift.min(max, self))
    }
    
    /// Return a uniformly distributed random number in the half open interval
    /// `[min, max)`
    ///
    /// :param: min Inclusive minimum value
    /// :param: max Exclusive maximum value
    /// :returns: A random number within the given interval
    public static func random(min: Double = 0, max: Double = 1) -> Double {
        let diff = max - min
        let rand = Double(arc4random_uniform(UInt32(RAND_MAX)))
        return ((rand / Double(RAND_MAX)) * diff) + min
    }
}

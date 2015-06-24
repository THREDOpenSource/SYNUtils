//
//  Double+Utils.swift
//  SYNUtils
//
//  Created by John Hurliman on 6/23/15.
//  Copyright (c) 2015 Syntertainment. All rights reserved.
//

import Foundation

public func lerp(a: Int, b: Int, t: Int) -> Int {
    return a + (b - a) * t
}

public func lerp(a: Float, b: Float, t: Float) -> Float {
    return a + (b - a) * t
}

public func lerp(a: Double, b: Double, t: Double) -> Double {
    return a + (b - a) * t
}

extension Double {
    public func abs() -> Double {
        return Foundation.fabs(self)
    }
    
    public func sqrt() -> Double {
        return Foundation.sqrt(self)
    }
    
    public func floor() -> Double {
        return Foundation.floor(self)
    }
    
    public func ceil() -> Double {
        return Foundation.ceil(self)
    }
    
    public func round() -> Double {
        return Foundation.round(self)
    }
    
    public func clamp(min: Double, _ max: Double) -> Double {
        return Swift.max(min, Swift.min(max, self))
    }
    
    public static func random(min: Double = 0, max: Double = 1) -> Double {
        let diff = max - min
        let rand = Double(arc4random_uniform(UInt32(RAND_MAX)))
        return ((rand / Double(RAND_MAX)) * diff) + min
    }
}

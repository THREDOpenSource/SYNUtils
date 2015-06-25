//
//  Math.swift
//  SYNUtils
//
//  Created by John Hurliman on 6/25/15.
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

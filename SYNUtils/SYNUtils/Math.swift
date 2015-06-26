//
//  Math.swift
//  SYNUtils
//
//  Created by John Hurliman on 6/25/15.
//  Copyright (c) 2015 Syntertainment. All rights reserved.
//

import Foundation

/// Linearly interpolate between two values.
///
/// :param: a Starting value
/// :param: b Ending value
/// :param: t Percent to interpolate from `a` to `b`, usually in the range [0-1]
/// :returns: The interpolated value
public func lerp(a: Float, b: Float, t: Float) -> Float {
    return a + (b - a) * t
}

/// Linearly interpolate between two values.
///
/// :param: a Starting value
/// :param: b Ending value
/// :param: t Percent to interpolate from `a` to `b`, usually in the range [0-1]
/// :returns: The interpolated value
public func lerp(a: Double, b: Double, t: Double) -> Double {
    return a + (b - a) * t
}

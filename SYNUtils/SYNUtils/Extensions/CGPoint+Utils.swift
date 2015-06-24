//
//  CGPoint+Utils.swift
//  SYNUtils
//
//  Created by John Hurliman on 6/23/15.
//  Copyright (c) 2015 Syntertainment. All rights reserved.
//

import CoreGraphics

// MARK: - CGPoint, CGPoint Operators

public func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPointMake(left.x + right.x, left.y + right.y)
}

public func - (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPointMake(left.x - right.x, left.y - right.y)
}

public func * (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPointMake(left.x * right.x, left.y * right.y)
}

public func / (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPointMake(left.x / right.x, left.y / right.y)
}

// MARK: - CGPoint, Scalar Operators

public func + (size: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPointMake(size.x + scalar, size.y + scalar)
}

public func - (size: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPointMake(size.x - scalar, size.y - scalar)
}

public func * (size: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPointMake(size.x * scalar, size.y * scalar)
}

public func / (size: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPointMake(size.x / scalar, size.y / scalar)
}

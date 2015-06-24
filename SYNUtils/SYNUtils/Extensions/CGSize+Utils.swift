//
//  CGSize+Utils.swift
//  SYNUtils
//
//  Created by John Hurliman on 6/23/15.
//  Copyright (c) 2015 Syntertainment. All rights reserved.
//

import CoreGraphics

extension CGSize {
    public func aspectFill(toSize: CGSize) -> CGSize {
        let ratioW = toSize.width / width
        let ratioH = toSize.height / height
        let ratio = ratioW > ratioH ? ratioW : ratioH
        
        return CGSizeMake(width * ratio, height * ratio)
    }
    
    public func aspectFit(toSize: CGSize) -> CGSize {
        let ratioW = toSize.width / width
        let ratioH = toSize.height / height
        let ratio = ratioW < ratioH ? ratioW : ratioH
        
        return CGSizeMake(width * ratio, height * ratio)
    }
}

// MARK: - CGSize, CGSize Operators

public func + (left: CGSize, right: CGSize) -> CGSize {
    return CGSizeMake(left.width + right.width, left.height + right.height)
}

public func - (left: CGSize, right: CGSize) -> CGSize {
    return CGSizeMake(left.width - right.width, left.height - right.height)
}

public func * (left: CGSize, right: CGSize) -> CGSize {
    return CGSizeMake(left.width * right.width, left.height * right.height)
}

public func / (left: CGSize, right: CGSize) -> CGSize {
    return CGSizeMake(left.width / right.width, left.height / right.height)
}

// MARK: - CGSize, Scalar Operators

public func + (size: CGSize, scalar: CGFloat) -> CGSize {
    return CGSizeMake(size.width + scalar, size.height + scalar)
}

public func - (size: CGSize, scalar: CGFloat) -> CGSize {
    return CGSizeMake(size.width - scalar, size.height - scalar)
}

public func * (size: CGSize, scalar: CGFloat) -> CGSize {
    return CGSizeMake(size.width * scalar, size.height * scalar)
}

public func / (size: CGSize, scalar: CGFloat) -> CGSize {
    return CGSizeMake(size.width / scalar, size.height / scalar)
}

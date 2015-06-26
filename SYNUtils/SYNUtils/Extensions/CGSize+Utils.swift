//
//  CGSize+Utils.swift
//  SYNUtils
//
//  Created by John Hurliman on 6/23/15.
//  Copyright (c) 2015 Syntertainment. All rights reserved.
//

import CoreGraphics

extension CGSize {
    /// Scales this size to fill a rectangle. Some portion of this size may
    /// extend beyond the bounds of the rectangle to fill the rectangle
    ///
    /// :param: toRect Target rectangle to fill
    /// :returns: A copy of this size, scaled to fill the target rectangle
    public func aspectFill(toSize: CGSize) -> CGSize {
        let ratioW = toSize.width / width
        let ratioH = toSize.height / height
        let ratio = ratioW > ratioH ? ratioW : ratioH
        
        return CGSizeMake(width * ratio, height * ratio)
    }
    
    /// Scales this size to fill the interior of a rectangle while maintaining
    /// this size's aspect ratio
    ///
    /// :param: toRect Target rectangle to fit inside of
    /// :returns: A copy of this size, scaled to fit the target rectangle
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

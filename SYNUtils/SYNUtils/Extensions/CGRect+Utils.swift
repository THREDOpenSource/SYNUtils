//
//  CGRect+Utils.swift
//  SYNUtils
//
//  Created by John Hurliman on 6/23/15.
//  Copyright (c) 2015 Syntertainment. All rights reserved.
//

import CoreGraphics

extension CGRect {
    /// Get the rectangle's midpoint
    public var center: CGPoint {
        return CGPoint(x: CGRectGetMidX(self), y: CGRectGetMidY(self))
    }
    
    /// Scales this rectangle to fill another rectangle. Some portion of this
    /// rectangle may extend beyond the bounds of the target rectangle to fill
    /// the target rectangle
    ///
    /// :param: toRect Target rectangle to fill
    /// :returns: A copy of this rectangle, scaled to fill the target rectangle
    public func aspectFill(toRect: CGRect) -> CGRect {
        let size = self.size.aspectFill(toRect.size)
        return CGRect(
            x: (toRect.size.width - size.width) * 0.5,
            y: (toRect.size.height - size.height) * 0.5,
            width: size.width,
            height: size.height
        )
    }
    
    /// Scales this rectangle to fill the interior of another rectangle while
    /// maintaining this rectangle's aspect ratio
    ///
    /// :param: toRect Target rectangle to fit inside of
    /// :returns: A copy of this rectangle, scaled to fit the target rectangle
    public func aspectFit(toRect: CGRect) -> CGRect {
        let size = self.size.aspectFit(toRect.size)
        var origin = toRect.origin
        origin.x += (toRect.size.width - size.width) * 0.5
        origin.y += (toRect.size.height - size.height) * 0.5
        return CGRect(origin: origin, size: size)
    }
}

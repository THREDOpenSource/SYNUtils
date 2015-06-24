//
//  CGRect+Utils.swift
//  SYNUtils
//
//  Created by John Hurliman on 6/23/15.
//  Copyright (c) 2015 Syntertainment. All rights reserved.
//

import CoreGraphics

extension CGRect {
    public var center: CGPoint {
        return CGPoint(x: CGRectGetMidX(self), y: CGRectGetMidY(self))
    }
    
    public func aspectFill(toRect: CGRect) -> CGRect {
        let size = self.size.aspectFill(toRect.size)
        return CGRect(
            x: (toRect.size.width - size.width) * 0.5,
            y: (toRect.size.height - size.height) * 0.5,
            width: size.width,
            height: size.height
        )
    }
    
    public func aspectFit(toRect: CGRect) -> CGRect {
        let size = self.size.aspectFit(toRect.size)
        var origin = toRect.origin
        origin.x += (toRect.size.width - size.width) * 0.5
        origin.y += (toRect.size.height - size.height) * 0.5
        return CGRect(origin: origin, size: size)
    }
}

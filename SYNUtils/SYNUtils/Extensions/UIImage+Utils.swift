//
//  UIImage+Utils.swift
//  SYNUtils
//
//  Created by John Hurliman on 6/23/15.
//  Copyright (c) 2015 Syntertainment. All rights reserved.
//

import Foundation

#if os(iOS)
    import UIKit.UIImage
#else
    import AppKit.NSImage
    public typealias UIImage = NSImage
    
    extension NSImage {
        /// Implementation of UIImage.CGImage
        public var CGImage: CGImageRef! {
            return CGImageForProposedRect(nil, context: nil, hints: nil)?.takeUnretainedValue()
        }
    
        /// Implementation of UIImage initializer missing from NSImage
        public convenience init?(CGImage cgImage: CGImageRef) {
            self.init(CGImage: cgImage, size: CGSizeZero)
        }
    }
#endif

extension UIImage {
    /// Create a 1x1 image filled with the specified color.
    ///
    /// :param: color Color to fill the image with
    /// :returns: New UIImage containing one pixel of the specified color
    public class func imageWithFill(color: UIColor) -> UIImage {
        let rect = CGRectMake(0, 0, 1, 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    /// Returns the actual pixel dimensions of an image, as opposed to
    /// `UIImage.size` which returns screen-scaled dimensions.
    public var pixelSize: CGSize {
        return size * scale
    }
}

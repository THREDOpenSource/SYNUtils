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
        public var CGImage: CGImageRef! {
            return CGImageForProposedRect(nil, context: nil, hints: nil)?.takeUnretainedValue()
        }
    
        // Optional to match UIImage
        public convenience init?(CGImage cgImage: CGImageRef) {
            self.init(CGImage: cgImage, size: CGSizeZero)
        }
    }
#endif

extension UIImage {
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
    
    public var pixelSize: CGSize {
        return size * scale
    }
}

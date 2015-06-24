//
//  UIColor+Utils.swift
//  SYNUtils
//
//  Created by John Hurliman on 6/23/15.
//  Copyright (c) 2015 Syntertainment. All rights reserved.
//

#if os(iOS)
    import UIKit.UIColor
#else
    import AppKit.NSColor
    public typealias UIColor = NSColor
    
    extension NSColor {
        public convenience init(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
            self.init(SRGBRed: red, green: green, blue: blue, alpha: alpha)
        }
    }
#endif

extension UIColor {
    // MARK: - Integer/Hex Conversions
    
    public convenience init(argb: UInt32) {
        if argb == 0 {
            self.init(white: 0.0, alpha: 1.0)
            return
        }
        
        var alpha = CGFloat((argb & 0xFF000000) >> 24) / 255.0
        if alpha == 0.0 { alpha = 1.0 }
        
        let red = CGFloat((argb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((argb & 0xFF00) >> 8) / 255.0
        let blue = CGFloat(argb & 0xFF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    public convenience init(hexString: String) {
        let scanner = NSScanner(string: hexString)
        var argb: UInt32 = 0
        scanner.scanHexInt(&argb)
        
        self.init(argb: argb)
    }
    
    public var argb: UInt32 {
        var red: CGFloat = 0.0, green: CGFloat = 0.0, blue: CGFloat = 0.0, alpha: CGFloat = 0.0
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        let alphaByte = UInt32(alpha * 0xFF) & 0xFF
        let redByte = UInt32(red * 0xFF) & 0xFF
        let greenByte = UInt32(green * 0xFF) & 0xFF
        let blueByte = UInt32(blue * 0xFF) & 0xFF
        
        return (alphaByte << 24) | (redByte << 16) | (greenByte << 8) | blueByte
    }
    
    public var hexString: String {
        var red: CGFloat = 0.0, green: CGFloat = 0.0, blue: CGFloat = 0.0
        self.getRed(&red, green: &green, blue: &blue, alpha: nil)
        
        let redByte = UInt8(red * 0xFF) & 0xFF
        let greenByte = UInt8(green * 0xFF) & 0xFF
        let blueByte = UInt8(blue * 0xFF) & 0xFF
        
        return String(format: "%02x%02x%02x", redByte, greenByte, blueByte)
    }
}

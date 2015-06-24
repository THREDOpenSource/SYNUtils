//
//  NSData+Utils.swift
//  SYNUtils
//
//  Created by John Hurliman on 6/23/15.
//  Copyright (c) 2015 Syntertainment. All rights reserved.
//

import Foundation

extension NSData {
    // MARK: - URL-Safe Base64 Encoding/Decoding
    
    public convenience init?(base64URLData: String) {
        let length = base64URLData.utf8Length
        let padChars = length + (4 - length % 4) % 4
        let padding = "".stringByPaddingToLength(padChars, withString: "=", startingAtIndex: 0)
        
        // Add padding
        var base64 = base64URLData + padding
        // - becomes +
        base64 = base64.stringByReplacingOccurrencesOfString("-", withString: "+")
        // _ becomes /
        base64 = base64.stringByReplacingOccurrencesOfString("_", withString: "/")
        // Decode
        self.init(base64EncodedString: base64, options: .IgnoreUnknownCharacters)
    }
    
    public func base64URLEncode() -> String {
        // Encode
        var base64 = self.base64EncodedStringWithOptions(NSDataBase64EncodingOptions())
        // Remove padding
        base64 = base64.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: "="))
        // + becomes -
        base64 = base64.stringByReplacingOccurrencesOfString("+", withString: "-")
        // / becomes _
        base64 = base64.stringByReplacingOccurrencesOfString("/", withString: "_")
        
        return base64
    }
    
    // MARK: - Hexadecimal String Conversions
    
    public convenience init?(hexString: String) {
        var data = NSMutableData()
        var temp = ""
        
        for char in hexString {
            temp += String(char)
            if(count(temp) == 2) {
                let scanner = NSScanner(string: temp)
                var value: CUnsignedInt = 0
                scanner.scanHexInt(&value)
                data.appendBytes(&value, length: 1)
                temp = ""
            }
        }
        
        self.init(data: data)
    }
    
    public func toHexString() -> String {
        var hexString = NSMutableString()
        
        let bytes = UnsafeBufferPointer<UInt8>(start: UnsafePointer(self.bytes), count:self.length)
        for byte in bytes {
            hexString.appendFormat("%02hhx", byte)
        }
        
        return hexString.copy() as! String
    }
}

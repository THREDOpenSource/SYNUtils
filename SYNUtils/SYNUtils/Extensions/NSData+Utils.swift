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
    
    /// Initialize NSData from a URL-safe base64 encoded string. URL-safe
    /// encoding replaces `+` and `/` with `-` and `_`, respectively, and does
    /// not contain `=` padding characters. For more information see
    /// <https://en.wikipedia.org/wiki/Base64#URL_applications>
    ///
    /// :param: base64URLData A URL-safe base64 encoded string
    /// :returns: NSData instance if the string was successfully decoded,
    ///   otherwise nil
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
    
    /// Convert this NSData to a URL-safe base64 encoded string. URL-safe
    /// encoding replaces `+` and `/` with `-` and `_`, respectively, and does
    /// not contain `=` padding characters. For more information see
    /// <https://en.wikipedia.org/wiki/Base64#URL_applications>
    ///
    /// :returns: A URL-safe base64 encoded string
    public func base64URLEncode() -> String {
        // Encode
        var base64 = self.base64EncodedStringWithOptions(nil)
        // Remove padding
        base64 = base64.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: "="))
        // + becomes -
        base64 = base64.stringByReplacingOccurrencesOfString("+", withString: "-")
        // / becomes _
        base64 = base64.stringByReplacingOccurrencesOfString("/", withString: "_")
        
        return base64
    }
    
    // MARK: - Hexadecimal String Conversions
    
    /// Convert this NSData to a hexadecimal string. The output will not include
    /// a "0x" prefix
    ///
    /// :returns: A hexadecimal string
    public func toHexString() -> String {
        let hexString = NSMutableString()
        
        let bytes = UnsafeBufferPointer<UInt8>(start: UnsafePointer(self.bytes), count:self.length)
        for byte in bytes {
            hexString.appendFormat("%02hhx", byte)
        }
        
        return hexString.copy() as! String
    }
}

//
//  NSString+Utils.swift
//  SYNUtils
//
//  Created by John Hurliman on 6/23/15.
//  Copyright (c) 2015 Syntertainment. All rights reserved.
//

import Foundation

extension String {
    struct CharacterSets {
        static var uri: NSCharacterSet = {
            return NSCharacterSet(charactersInString: "!*'();:@&=+$,/?%#[]\" ").invertedSet
        }()
        
        static var whitespaceAndNewline: NSCharacterSet = {
            return NSCharacterSet.whitespaceAndNewlineCharacterSet()
        }()
    }
    
    public func range(startOffset: Int = 0, endOffset: Int = 0) -> Range<String.Index> {
        return Range<String.Index>(
            start: advance(self.startIndex, startOffset),
            end: advance(self.endIndex, endOffset))
    }
    
    public func trim() -> String {
        return self.stringByTrimmingCharactersInSet(CharacterSets.whitespaceAndNewline)
    }
    
    public func uriEncoded() -> String {
        return self.stringByAddingPercentEncodingWithAllowedCharacters(CharacterSets.uri)!
    }
    
    public func md5Sum() -> String {
        if let data = self.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
            return MD5(data).calculate().toHexString()
        } else {
            return "00000000000000000000000000000000"
        }
    }
    
    // MARK: - String Length
    
    public var length: Int {
        return count(self)
    }
    
    public var utf8Length: Int {
        return count(self.utf8)
    }
    
    public var utf16Length: Int {
        return count(self.utf16)
    }
    
    // MARK: - Validation
    
    public var isValidURL: Bool {
        if let candidateURL = NSURL(string: self) {
            return candidateURL.scheme != nil && candidateURL.host != nil
        }
        
        return false
    }
    
    public var isValidEmail: Bool {
        let emailRegex = "[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluateWithObject(self)
    }
}

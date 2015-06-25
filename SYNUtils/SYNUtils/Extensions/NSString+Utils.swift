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
    
    public func startsWith(str: String) -> Bool {
        if let range = rangeOfString(str) {
            return range.startIndex == startIndex
        }
        return false
    }
    
    public func endsWith(str: String) -> Bool {
        if let range = rangeOfString(str) {
            return range.endIndex == endIndex
        }
        return false
    }
    
    public func contains(str: String) -> Bool {
        return rangeOfString(str) != nil
    }
    
    public func match(regex: RegExp) -> [String] {
        let nsSelf = self as NSString
        let matches = regex.matchesInString(self, options: nil, range: fullNSRange()) as! [NSTextCheckingResult]
        return matches.map { return nsSelf.substringWithRange($0.range) }
    }
    
    public func replace(target: String, withString replacement: String,
        options: NSStringCompareOptions = .LiteralSearch,
        range searchRange: Range<Int>? = nil) -> String
    {
        let searchRange: Range<String.Index>? = (searchRange != nil) ? toStringRange(searchRange!) : nil
        return stringByReplacingOccurrencesOfString(target, withString: replacement,
            options: options, range: searchRange)
    }
    
    public func split(separator: String) -> [String] {
        return componentsSeparatedByString(separator)
    }
    
    public func split(separators: NSCharacterSet) -> [String] {
        return componentsSeparatedByCharactersInSet(separators)
    }
    
    public func substr(range: Range<Int>) -> String {
        return substr(toStringRange(range))
    }
    
    public func substr(range: Range<String.Index>) -> String {
        return substringWithRange(range)
    }
    
    public func trim() -> String {
        return stringByTrimmingCharactersInSet(CharacterSets.whitespaceAndNewline)
    }
    
    public func uriEncoded() -> String {
        return stringByAddingPercentEncodingWithAllowedCharacters(CharacterSets.uri)!
    }
    
    public func md5Sum() -> String {
        if let data = dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
            return MD5(data).calculate().toHexString()
        } else {
            return "00000000000000000000000000000000"
        }
    }
    
    // MARK: - Range Helpers
    
    public func rangeWithOffsets(startOffset: Int = 0, endOffset: Int = 0) -> Range<String.Index> {
        return Range<String.Index>(
            start: advance(startIndex, startOffset),
            end: advance(endIndex, endOffset)
        )
    }
    
    public func toStringRange(range: Range<Int>) -> Range<String.Index> {
        return Range(
            start: advance(startIndex, range.startIndex),
            end: advance(startIndex, range.endIndex)
        )
    }
    
    public func fullNSRange() -> NSRange {
        return NSMakeRange(0, (self as NSString).length)
    }
    
    // MARK: - String Length
    
    public var length: Int {
        return count(self)
    }
    
    public var utf8Length: Int {
        return count(utf8)
    }
    
    public var utf16Length: Int {
        return count(utf16)
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
    
    // MARK: - Subscript Access
    
    public subscript(i: Int) -> Character {
        return self[advance(startIndex, i)]
    }
    
    public subscript(i: Int) -> String {
        return String(self[i] as Character)
    }
    
    public subscript(r: Range<Int>) -> String {
        return substringWithRange(toStringRange(r))
    }
}

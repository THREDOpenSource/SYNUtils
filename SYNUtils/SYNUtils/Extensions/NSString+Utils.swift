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
    
    /// Test if this string starts with a given string.
    ///
    /// :param: prefix String to test against the beginning of the current
    ///   string
    /// :returns: True if this string starts with the given prefix
    public func startsWith(prefix: String) -> Bool {
        return hasPrefix(prefix)
    }
    
    /// Test if this string ends with a given string.
    ///
    /// :param: suffix String to test against the ending of the current string
    /// :returns: True if this string ends with the given suffix
    public func endsWith(suffix: String) -> Bool {
        return hasSuffix(suffix)
    }
    
    /// Test if this string contains a given string.
    ///
    /// :param: needle String to search for
    /// :returns: True if this string contains the given string
    public func contains(needle: String) -> Bool {
        return rangeOfString(needle) != nil
    }
    
    /// Find all matches in this string for a given regular expression. This
    /// method does not support capture groups (use `RegExp#exec()`).
    ///
    /// :param: regex Regular expression to execute against this string
    /// :returns: Array of zero or more
    public func match(regex: RegExp) -> [String] {
        let nsSelf = self as NSString
        let matches = regex.matchesInString(self, options: nil, range: fullNSRange()) as! [NSTextCheckingResult]
        return matches.map { return nsSelf.substringWithRange($0.range) }
    }
    
    /// Returns a new string by replacing all instances of a given substring
    /// with another string.
    ///
    /// :param: target Substring to search and replace in this string
    /// :param: withString Replacement string
    /// :param: options String comparison options
    /// :param: range Limit search and replace to a specific range
    /// :returns: New string with all instances of `target` replaced by
    ///   `withString`
    public func replace(target: String, withString replacement: String,
        options: NSStringCompareOptions = .LiteralSearch,
        range searchRange: Range<Int>? = nil) -> String
    {
        let searchRange: Range<String.Index>? = (searchRange != nil) ? toStringRange(searchRange!) : nil
        return stringByReplacingOccurrencesOfString(target, withString: replacement,
            options: options, range: searchRange)
    }
    
    /// Returns an array containing substrings from this string that have been
    /// divided by a given separator.
    ///
    /// :param: separator Separator string to split on. Example: ":"
    /// :returns: Array of substrings
    public func split(separator: String) -> [String] {
        return componentsSeparatedByString(separator)
    }
    
    /// Returns an array containing substrings from this string that have been
    /// divided by a given set of separator characters.
    ///
    /// :param: separators Separator characters to split on
    /// :returns: Array of substrings
    public func split(separators: NSCharacterSet) -> [String] {
        return componentsSeparatedByCharactersInSet(separators)
    }
    
    /// Returns a substring specified by a given character range.
    ///
    /// :param: range Character range to extract
    /// :returns: Extracted substring
    public func substr(range: Range<Int>) -> String {
        return substr(toStringRange(range))
    }
    
    /// Returns a substring specified by a given string range.
    ///
    /// :param: range String range to extract
    /// :returns: Extracted substring
    public func substr(range: Range<String.Index>) -> String {
        return substringWithRange(range)
    }
    
    /// Returns a substring starting at the specified character offset.
    ///
    /// :param: startIndex Inclusive starting character index
    /// :returns: Extracted substring
    public func substr(startIndex: Int) -> String {
        return substr(startIndex..<self.length)
    }
    
    /// Returns a string with leading and trailing whitespace and newlines
    /// removed.
    ///
    /// :returns: Trimmed string
    public func trim() -> String {
        return stringByTrimmingCharactersInSet(CharacterSets.whitespaceAndNewline)
    }
    
    /// Returns a string with non-URI-safe characters escaped using percent
    /// encoding.
    ///
    /// :returns: Escaped string
    public func uriEncoded() -> String {
        return stringByAddingPercentEncodingWithAllowedCharacters(CharacterSets.uri)!
    }
    
    /// Returns this string's MD5 checksum as a hexidecimal string.
    ///
    /// :returns: 32 character hexadecimal string
    public func md5Sum() -> String {
        if let data = dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
            return MD5(data).calculate().toHexString()
        } else {
            return "00000000000000000000000000000000"
        }
    }
    
    // MARK: - Range Helpers
    
    /// Construct a string range by specifying relative offsets from the
    /// beginning and end of this string.
    ///
    /// :param: startOffset Relative offset from the beginning of this string.
    ///   Must be >= 0
    /// :param: endOffset Relative offset from the end of this string. Must be
    ///   <= 0
    /// :returns: `Range<String.Index>` for this string
    public func rangeWithOffsets(startOffset: Int = 0, endOffset: Int = 0) -> Range<String.Index> {
        assert(startOffset >= 0, "Can not create a range extending before startOffset")
        assert(endOffset <= 0, "Can not create a range extending beyond endOffset")
        
        return Range<String.Index>(
            start: advance(startIndex, startOffset),
            end: advance(endIndex, endOffset)
        )
    }
    
    /// Convert a range specified as character positions to a string range.
    ///
    /// :param: range Character position range. Example: `(0...5)`
    /// :returns: `Range<String.Index>` for this string
    public func toStringRange(range: Range<Int>) -> Range<String.Index> {
        return Range(
            start: advance(startIndex, range.startIndex),
            end: advance(startIndex, range.endIndex)
        )
    }
    
    /// Convert an NSRange to a string range.
    ///
    /// :param: NSRange to convert
    /// :returns: `Range<String.Index>` for this string
    public func toStringRange(range: NSRange) -> Range<String.Index>? {
        if  let from = String.Index(utf16.startIndex + range.location, within: self),
            let to = String.Index(utf16.startIndex + range.location + range.length, within: self)
        {
            return from ..< to
        }
        return nil
    }
    
    /// Returns an NSRange representing the entire length of this string.
    ///
    /// :returns: `NSRange`
    public func fullNSRange() -> NSRange {
        return NSMakeRange(0, (self as NSString).length)
    }
    
    // MARK: - String Length
    
    /// Returns the character count of this string. More specifically, this
    /// counts the number of Unicode grapheme clusters in the string. This is
    /// the slowest method for string length but the only accurate method that
    /// handles all Unicode characters such as emojis.
    public var length: Int {
        return count(self)
    }
    
    /// Returns the number of UTF8-encoded characters in this string. This is
    /// not always equal to the character count, see `length` for more info.
    public var utf8Length: Int {
        return count(utf8)
    }
    
    /// Returns the number of UTF16-encoded characters in this string. This is
    /// not always equal to the character count, see `length` for more info.
    public var utf16Length: Int {
        return count(utf16)
    }
    
    // MARK: - Validation
    
    /// Returns true if this string can successfully be parsed as an `NSURL`
    /// with non-empty scheme and host.
    ///
    /// :returns: True if this string is a valid URL
    public var isValidURL: Bool {
        if let candidateURL = NSURL(string: self) {
            return candidateURL.scheme != nil && candidateURL.host != nil
        }
        
        return false
    }
    
    /// Returns true if this string passes a lenient regular expression test for
    /// email validation. Note that fully validating an email address according
    /// to RFC 2822 and checking for an Internet-routable domain is a
    /// non-trivial problem. Therefore, this check errors on the side of
    /// leniency, allowing potentially unroutable addresses to pass validation.
    ///
    /// :returns: True if this string looks like a valid email address.
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

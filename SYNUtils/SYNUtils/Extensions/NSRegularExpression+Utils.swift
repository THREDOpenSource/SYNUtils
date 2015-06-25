//
//  NSRegularExpression.swift
//  SYNUtils
//
//  Created by John Hurliman on 6/24/15.
//  Copyright (c) 2015 Syntertainment. All rights reserved.
//

import Foundation

public typealias RegExp = NSRegularExpression

/// Represents a single regular expression match, including a string value and
/// zero or more capture group strings
public struct RegExpMatch {
    /// The complete matched string
    public let value: String
    
    /// Range of the input string containing this match
    public let range: Range<String.Index>
    
    /// Array of capture groups for this match, if any capture groups were
    /// specified in the regular expression
    public let captureGroups: [String]
}

/// A sequence of matches for a regular expression
public struct RegExpMatches : SequenceType {
    private let matches: [RegExpMatch]
    public var count: Int { return matches.count }
    public let input: String
    
    init(matches: [RegExpMatch], input: String) {
        self.matches = matches
        self.input = input
    }
    
    init(re: RegExp, haystack: String) {
        var matches = [RegExpMatch]()
        let nsHaystack = haystack as NSString
        
        re.enumerateMatchesInString(haystack, options: nil, range: haystack.fullNSRange()) {
            (result: NSTextCheckingResult!, _, _) in
            
            let value = nsHaystack.substringWithRange(result.range)
            let captureGroups = (1..<result.numberOfRanges).map {
                return nsHaystack.substringWithRange(result.rangeAtIndex($0))
            }
            
            let match = RegExpMatch(value: value, range: haystack.toStringRange(result.range)!, captureGroups: captureGroups)
            matches.append(match)
        }
        
        self.init(matches: matches, input: haystack)
    }
    
    // MARK: - Array Implementation
    
    public func generate() -> GeneratorOf<RegExpMatch> {
        var nextIndex = 0
        return GeneratorOf<RegExpMatch> {
            if nextIndex >= self.matches.count { return nil }
            return self.matches[nextIndex++]
        }
    }
    
    public subscript(index: Int) -> RegExpMatch {
        return matches[index]
    }
}

extension NSRegularExpression {
    /// Simple initializer for building a regular expression from a string
    /// pattern.
    ///
    /// :param: pattern Regular expression pattern
    /// :param: ignoreCase Toggles case-insensitive regular expression
    ///   construction
    /// :returns: An NSRegularExpression if the given expression pattern was
    /// successfully parsed, otherwise nil
    public convenience init?(_ pattern: String, ignoreCase: Bool = false) {
        var options = NSRegularExpressionOptions.DotMatchesLineSeparators.rawValue
        if ignoreCase {
            options = NSRegularExpressionOptions.CaseInsensitive.rawValue | options
        }
        
        var error: NSError? = nil
        self.init(pattern: pattern, options: NSRegularExpressionOptions(rawValue: options), error: &error)
        if error != nil { return nil }
    }
    
    /// Execute this regular expression against a given string and return all
    /// matches and capture groups.
    ///
    /// :param: haystack The string to execute this regular expression against
    /// :returns: A `RegExpMatches` object containing each match which in turn
    ///   contains the matching value, range, and capture groups
    public func exec(string: String) -> RegExpMatches {
        return RegExpMatches(re: self, haystack: string)
    }
    
    /// Test if this regular expression matches one or more times against a
    /// given string.
    ///
    /// :param: string The string to test this regular expression against
    /// :returns: True ifthe regular expression matched one or more times,
    /// otherwise false
    public func test(string: String) -> Bool {
        return numberOfMatchesInString(string, options: nil, range: string.fullNSRange()) > 0
    }
}

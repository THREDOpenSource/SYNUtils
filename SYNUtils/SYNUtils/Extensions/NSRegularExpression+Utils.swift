//
//  NSRegularExpression.swift
//  SYNUtils
//
//  Created by John Hurliman on 6/24/15.
//  Copyright (c) 2015 Syntertainment. All rights reserved.
//

import Foundation

public typealias RegExp = NSRegularExpression

public struct RegExpMatch {
    public let value: String
    // FIXME: Implement once we have the helpers to safely convert from NSRange to Range<String.Index>
    //public let index: String.Index
    public let captureGroups: [String]
}

public struct RegExpMatches : SequenceType {
    private let matches: [RegExpMatch]
    public var count: Int { return matches.count }
    public let input: String
    
    public init(matches: [RegExpMatch], input: String) {
        self.matches = matches
        self.input = input
    }
    
    public init(re: RegExp, haystack: String) {
        var matches = [RegExpMatch]()
        let nsHaystack = haystack as NSString
        
        re.enumerateMatchesInString(haystack, options: nil, range: haystack.fullNSRange()) {
            (result: NSTextCheckingResult!, _, _) in
            
            let value = nsHaystack.substringWithRange(result.range)
            let captureGroups = (1..<result.numberOfRanges).map {
                return nsHaystack.substringWithRange(result.rangeAtIndex($0))
            }
            let match = RegExpMatch(value: value, captureGroups: captureGroups)
            
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
    public convenience init?(_ pattern: String, ignoreCase: Bool = false) {
        var options = NSRegularExpressionOptions.DotMatchesLineSeparators.rawValue
        if ignoreCase {
            options = NSRegularExpressionOptions.CaseInsensitive.rawValue | options
        }
        
        var error: NSError? = nil
        self.init(pattern: pattern, options: NSRegularExpressionOptions(rawValue: options), error: &error)
        if error != nil { return nil }
    }
    
    public func exec(haystack: String) -> RegExpMatches {
        return RegExpMatches(re: self, haystack: haystack)
    }
    
    public func test(string: String) -> Bool {
        return numberOfMatchesInString(string, options: nil, range: string.fullNSRange()) > 0
    }
}

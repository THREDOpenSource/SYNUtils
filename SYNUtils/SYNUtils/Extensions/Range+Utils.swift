//
//  Range+Utils.swift
//  SYNUtils
//
//  Created by John Hurliman on 6/24/15.
//  Copyright (c) 2015 Syntertainment. All rights reserved.
//

import Foundation

extension Range {
    func each(function: (T) -> ()) {
        for i in self { function(i) }
    }
    
    func map(function: (T) -> AnyObject?) -> [AnyObject?] {
        var output = [AnyObject?]()
        for i in self { output.append(function(i)) }
        return output
    }
    
    func toArray() -> [T] {
        var output = [T]()
        for i in self { output.append(i) }
        return output
    }
}

public func == <U: ForwardIndexType> (left: Range<U>, right: Range<U>) -> Bool {
    return left.startIndex == right.startIndex && left.endIndex == right.endIndex
}

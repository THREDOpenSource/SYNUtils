//
//  Range+Utils.swift
//  SYNUtils
//
//  Created by John Hurliman on 6/24/15.
//  Copyright (c) 2015 Syntertainment. All rights reserved.
//

import Foundation

extension Range {
    /// Execute a function for each element in the range.
    ///
    /// :param: function Function to run for each element
    func each(function: T -> ()) {
        for i in self { function(i) }
    }
    
    /// Map each element in this range to an output value.
    ///
    /// :param: function Function mapping a range element to an output value
    /// :returns: An array of output values
    func map<V: AnyObject>(function: T -> V) -> [V] {
        var output = [V]()
        for i in self { output.append(function(i)) }
        return output
    }
    
    /// Convert this range to an array.
    ///
    /// :returns: An array containing each element in the range
    func toArray() -> [T] {
        var output = [T]()
        for i in self { output.append(i) }
        return output
    }
}

public func == <U: ForwardIndexType> (left: Range<U>, right: Range<U>) -> Bool {
    return left.startIndex == right.startIndex && left.endIndex == right.endIndex
}

//
//  Dictionary+Utils.swift
//  SYNUtils
//
//  Created by John Hurliman on 6/23/15.
//  Copyright (c) 2015 Syntertainment. All rights reserved.
//

import Foundation

extension Dictionary {
    /// Convert a dictionary to an array of values sorted by the dictionary keys
    ///
    ///   Dictionary.sortByKeys([2: "a", 1: "b"]) // Returns ["b", "a"]
    ///
    /// :param: dictionary Dictionary to sort
    /// :returns: An array of values sorted by their corresponding keys in the
    ///   dictionary
    static func sortByKeys<K: Comparable, V>(dictionary: [K: V]) -> [V] {
        // Build an array of key-value tuples
        var array = [(K, V)]()
        array.reserveCapacity(dictionary.count)
        for (key, value) in dictionary {
            array.append((key, value))
        }
        
        // Sort the tuples by key and map to an array of values
        array.sort { $0.0 < $1.0 }
        return array.map { $0.1 }
    }
    
    /// Map all of the `(key, value)` tuples in this dictionary to new key value
    /// pairs in a new dictionary. The behavior is undefined for two or more
    /// keys mapping to the same output key
    ///
    ///   ["a": 1, "b": 2].map { return ("*" + $0, $1 * 3) } // Returns ["*a": 3, "*b": 6]
    ///
    /// :param: transform Function that is called once for each key value pair
    ///   and returns a new key value pair
    /// :returns: Dictionary consisting of the mapped key value pairs
    func map<K: Hashable, V> (transform: (Key, Value) -> (K, V)) -> [K: V] {
        var output = [K: V]()
        for (key, value) in self {
            let newKeyValue = transform(key, value)
            output[newKeyValue.0] = newKeyValue.1
        }
        return output
    }
}

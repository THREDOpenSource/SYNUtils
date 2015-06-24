//
//  Dictionary+Utils.swift
//  SYNUtils
//
//  Created by John Hurliman on 6/23/15.
//  Copyright (c) 2015 Syntertainment. All rights reserved.
//

import Foundation

extension Dictionary {
    // FIXME: Make this public in Swift 2.0
    func map<K: Hashable, V> (transform: (Key, Value) -> (K, V)) -> Dictionary<K, V> {
        var output = [K: V]()
        for (key, value) in self {
            let newKeyValue = transform(key, value)
            output[newKeyValue.0] = newKeyValue.1
        }
        return output
    }
}

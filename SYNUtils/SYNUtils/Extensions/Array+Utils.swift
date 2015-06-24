//
//  Array+Utils.swift
//  SYNUtils
//
//  Created by John Hurliman on 6/23/15.
//  Copyright (c) 2015 Syntertainment. All rights reserved.
//

import Foundation

extension Array {
    typealias ElementCallback = Element -> Void
    typealias IndexedElementCallback = (Int, Element) -> Void
    typealias TestCallback = (Element) -> Bool
    
    func indexOf<U: Equatable>(item: U) -> Int? {
        if item is Element {
            return find(unsafeBitCast(self, [U].self), item)
        }
        
        return nil
    }
    
    func indexOf(condition: Element -> Bool) -> Int? {
        for (index, element) in enumerate(self) {
            if condition(element) { return index }
        }
        
        return nil
    }
    
    func each(function: ElementCallback) {
        for item in self {
            function(item)
        }
    }
    
    func each(function: IndexedElementCallback) {
        for (index, item) in enumerate(self) {
            function(index, item)
        }
    }
    
    func contains<T: Equatable>(items: T...) -> Bool {
        return items.every { self.indexOf($0) >= 0 }
    }
    
    func some(test: TestCallback) -> Bool {
        for item in self {
            if test(item) { return true }
        }
        
        return false
    }
    
    func every(test: TestCallback) -> Bool {
        for item in self {
            if !test(item) { return false }
        }
        
        return true
    }
    
    mutating func pop() -> Element? {
        return count > 0 ? removeAtIndex(count - 1) : nil
    }
    
    mutating func shift() -> Element? {
        return count > 0 ? removeAtIndex(0) : nil
    }
    
    mutating func fill(value: Element, count: Int) {
        for i in 0..<count {
            append(value)
        }
    }
    
    // MARK: - Misc
    
    func chooseRandom() -> T? {
        if self.count == 0 { return nil }
        
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}

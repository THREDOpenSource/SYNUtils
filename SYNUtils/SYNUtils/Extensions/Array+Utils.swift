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
    typealias TestCallback = Element -> Bool
    
    /// Convert an array of optional types to non-optional types by removing any
    /// nil entries.
    ///
    ///   let compacted: [Int] = [1, 2, nil, 3].compact()
    ///
    /// :param: array Array of optional types
    /// :returns: A copy of the given array, typecasted with nil entries removed
    static func compact(array: [T?]) -> [T] {
        return array.filter { $0 != nil }.map { $0! }
    }
    
    /// Return the index of the first array element equal to `item`.
    ///
    ///   if let index = [1, 2, 3].indexOf(2) { ... }
    ///
    /// :param: item The item to search for
    /// :returns: A zero-based index for the first matching element in the
    ///   array, otherwise nil
    func indexOf<U: Equatable>(item: U) -> Int? {
        if item is Element {
            return find(unsafeBitCast(self, [U].self), item)
        }
        
        return nil
    }
    
    /// Return the index of the first array element where the supplied function
    /// returns true.
    ///
    ///   if let index = [1, 2, 3].indexOf({ $0 == 2 }) { ... }
    ///
    /// :param: condition Function that takes an array element and returns true
    ///   for a match, otherwise false
    /// :returns: A zero-based index for the first matching element in the
    ///   array, otherwise nil
    func indexOf(condition: TestCallback) -> Int? {
        for (index, element) in enumerate(self) {
            if condition(element) { return index }
        }
        
        return nil
    }
    
    /// Execute a function for each element in the array.
    ///
    ///   [1, 2, 3].each { println($0) }
    ///
    /// :param: function Function to run for each element
    func each(function: ElementCallback) {
        for item in self {
            function(item)
        }
    }
    
    /// Execute a function for each index and element tuple in the array.
    ///
    ///   [1, 2, 3].each { println("Index \($0) = \($1)") }
    ///
    /// :param: function Function to run for each index and element tuple
    func each(function: IndexedElementCallback) {
        for (index, item) in enumerate(self) {
            function(index, item)
        }
    }
    
    /// Test if the array contains one or more elements.
    ///
    ///   if [1, 2, 3].contains(2, 3) { ... }
    ///
    /// :param: items One or more elements to search for in the array. The array
    ///   must contain all of the given elements for this method to return true
    /// :returns: True if all of the given elements were found in the array,
    ///   otherwise false
    func contains<T: Equatable>(items: T...) -> Bool {
        return items.every { self.indexOf($0) >= 0 }
    }
    
    /// Test if any of the array elements pass a given condition.
    ///
    ///   if [1, 2, 3].some({ $0 == 2 }) { ... }
    ///
    /// :param: test Function that takes an array element and returns true or
    ///   false
    /// :returns: True the first time an array element passes the test function,
    ///   otherwise false
    func some(test: TestCallback) -> Bool {
        for item in self {
            if test(item) { return true }
        }
        
        return false
    }
    
    /// Test if all of the array elements pass a given condition.
    ///
    ///   if [1, 2, 3].every({ $0 is Int }) { ... }
    ///
    /// :param: test Function that takes an array element and returns true or
    ///   false
    /// :returns: True if every array element passes the test function,
    ///   otherwise false the first time an element fails the test
    func every(test: TestCallback) -> Bool {
        for item in self {
            if !test(item) { return false }
        }
        
        return true
    }
    
    /// Flatten the elements of this array into a string, with the `separator`
    /// string between each element in the output string.
    ///
    ///   [1, 2, 3].joinWithString("-") // "1-2-3"
    ///
    /// :param: separator String to place between each element
    /// :returns: A string representation of the array
    func joinWithString(separator: String) -> String {
        return separator.join(self.map { "\($0)" })
    }
    
    /// Return a randomly chosen element from the array.
    ///
    ///   if let num = [1, 2, 3].chooseRandom() { println("Chose \(num)") }
    ///
    /// :returns: A randomly chosen element, or nil if the array is empty
    func chooseRandom() -> T? {
        if self.count == 0 { return nil }
        
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
    
    // MARK: - Mutating Methods
    
    /// Remove the last element from the array and return it.
    ///
    ///   [1, 2, 3].pop() // Array becomes [1, 2]
    ///
    /// :returns: The last element in the array, or nil if the array is empty
    mutating func pop() -> Element? {
        return count > 0 ? removeAtIndex(count - 1) : nil
    }
    
    /// Remove the first element from the array and return it.
    ///
    ///   [1, 2, 3].shift() // Array becomes [2, 3]
    ///
    /// :returns: The first element in the array, or nil if the array is empty
    mutating func shift() -> Element? {
        return count > 0 ? removeAtIndex(0) : nil
    }
    
    /// Add an element to the beginning of the array.
    ///
    ///   [1, 2, 3].unshift(0) // Array becomes [0, 1, 2, 3]
    ///
    /// :param: item New item to prepend to the array
    mutating func unshift(item: T) {
        insert(item, atIndex: 0)
    }
    
    /// Add an element to the array a given number of times.
    ///
    ///   [].fill("a", 3) // Array becomes ["a", "a", "a"]
    ///
    /// :param: value New element to append to the array
    /// :param: count Number of times to append the new element
    mutating func fill(value: Element, count: Int) {
        for _ in 0..<count {
            append(value)
        }
    }
}

//
//  NSObject+Utils.swift
//  SYNUtils
//
//  Created by John Hurliman on 6/23/15.
//  Copyright (c) 2015 Syntertainment. All rights reserved.
//

import Foundation

extension NSObject {
    /// Retrieve an associated object. Associated objects allow NSObject-derived
    /// objects to be associated with a parent NSObject-derived object and a
    /// given key. They are particularly useful for adding new members to an
    /// object via extensions.
    ///
    /// :param: key Key used to store the associated object being retrieved
    /// :returns: Value associated with the given key on this object if it
    ///   exists and matches the expected type, otherwise nil
    public func getAssociatedObject<T: NSObject>(key: UnsafePointer<Void>) -> T? {
        return objc_getAssociatedObject(self, key) as? T
    }
    
    /// Set an associated object. Associated objects allow NSObject-derived
    /// objects to be associated with a parent NSObject-derived object and a
    /// given key. They are particularly useful for adding new members to an
    /// object via extensions
    ///
    /// :param: key Key used to store the associated object
    /// :param: value Object to store
    public func setAssociatedObject<T: NSObject>(key: UnsafePointer<Void>, _ value: T?) {
        objc_setAssociatedObject(self, key, value, UInt(OBJC_ASSOCIATION_RETAIN))
    }
    
    /// Retrieve an associated object that is lazily initialized. See
    /// `getAssociatedObject` for more information on associated objects.
    ///
    /// :param: key Key used to store the associated object being retrieved
    /// :param: initializer Function that instantiates the associated object.
    ///   This method is run only once the first time the object is accessed
    public func lazyAssociatedObject<T: NSObject>(key: UnsafePointer<Void>, initializer: () -> T) -> T {
        return objc_getAssociatedObject(self, key) as? T ?? {
            let obj = initializer()
            objc_setAssociatedObject(self, key, obj, UInt(OBJC_ASSOCIATION_RETAIN))
            return obj
        }()
    }
}

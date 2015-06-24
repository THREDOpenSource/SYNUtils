//
//  NSObject+Utils.swift
//  SYNUtils
//
//  Created by John Hurliman on 6/23/15.
//  Copyright (c) 2015 Syntertainment. All rights reserved.
//

import Foundation

extension NSObject {
    public func associatedObject<T: NSObject>(key: UnsafePointer<Void>, initializer: () -> T) -> T {
        if let obj = objc_getAssociatedObject(self, key) as? T {
            return obj
        } else {
            let obj = initializer()
            objc_setAssociatedObject(self, key, obj, UInt(OBJC_ASSOCIATION_RETAIN))
            return obj
        }
    }
}

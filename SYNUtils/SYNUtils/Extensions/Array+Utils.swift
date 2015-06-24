//
//  Array+Utils.swift
//  SYNUtils
//
//  Created by John Hurliman on 6/23/15.
//  Copyright (c) 2015 Syntertainment. All rights reserved.
//

import Foundation

extension Array {
    // FIXME: Make this public in Swift 2.0
    func chooseRandom() -> T? {
        if self.count == 0 { return nil }
        
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}

//
//  Double+Utils.swift
//  SYNUtils
//
//  Created by John Hurliman on 6/23/15.
//  Copyright (c) 2015 Syntertainment. All rights reserved.
//

import Foundation

extension Double {
    public static func random() -> Double {
        return Double(arc4random_uniform(UINT32_MAX)) / Double(UINT32_MAX);
    }
}

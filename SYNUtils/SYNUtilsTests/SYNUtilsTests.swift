//
//  SYNUtilsTests.swift
//  SYNUtilsTests
//
//  Created by John Hurliman on 6/23/15.
//  Copyright (c) 2015 Syntertainment. All rights reserved.
//

import UIKit
import XCTest
import SYNUtils

class SYNUtilsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}

class NSRegularExpressionTests: XCTestCase {
    let abcs = "abcdef"
    let emojis = "👹👀🐼📱"
    let qbfjold = "The Quick Brown Fox Jumps Over The Lazy Dog"
    
    func testCreation() {
        XCTAssertNotNil(RegExp("abc"))
        XCTAssertNotNil(RegExp("ab+c"))
        XCTAssertNil(RegExp("["))
    }
    
    func testExec() {
        
    }
    
    func testTest() {
        
    }
    
    func testCaseSensitivity() {
        
    }
}

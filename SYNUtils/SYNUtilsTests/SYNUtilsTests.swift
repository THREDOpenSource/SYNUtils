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

class NSRegularExpressionTests: XCTestCase {
    let abcs = "abcdef"
    let emojis = "👹👀🐼📱"
    let qbfjold = "The Quick Brown Fox Jumps Over The Lazy Dog"
    
    func testCreation() {
        XCTAssertNotNil(RegExp("abc"))
        XCTAssertNotNil(RegExp("ab+c"))
        XCTAssertNil(RegExp("["))
        
        XCTAssertNotNil(RegExp("abc", ignoreCase: true))
        XCTAssertNotNil(RegExp("ab+c", ignoreCase: true))
        XCTAssertNil(RegExp("[", ignoreCase: true))
    }
    
    func testExec() {
        let re1 = RegExp(".")
        let matches1 = re1!.exec(abcs)
        XCTAssertEqual(matches1.input, abcs)
        XCTAssertEqual(count(abcs), matches1.count)
        for match in matches1 {
            XCTAssertEqual(0, match.captureGroups.count)
        }
        XCTAssertEqual(matches1[0].value, "a")
        XCTAssertEqual(matches1[5].value, "f")
        
        let re2 = RegExp("(.)(.)(.)")
        let matches2 = re2!.exec(abcs)
        XCTAssertEqual(matches2.input, abcs)
        XCTAssertEqual(count(abcs) / 3, matches2.count)
        XCTAssertEqual("abc", matches2[0].value)
        XCTAssertEqual("def", matches2[1].value)
        XCTAssertEqual(3, matches2[0].captureGroups.count)
        XCTAssertEqual(3, matches2[1].captureGroups.count)
        XCTAssertEqual("a", matches2[0].captureGroups[0])
        XCTAssertEqual("b", matches2[0].captureGroups[1])
        XCTAssertEqual("c", matches2[0].captureGroups[2])
        XCTAssertEqual("d", matches2[1].captureGroups[0])
        XCTAssertEqual("e", matches2[1].captureGroups[1])
        XCTAssertEqual("f", matches2[1].captureGroups[2])
        
        let re3 = RegExp("🐼")
        let matches3 = re3!.exec(emojis)
        XCTAssertEqual(1, matches3.count)
        XCTAssertEqual("🐼", matches3[0].value)
        XCTAssertEqual(0, matches3[0].captureGroups.count)
    }
    
    func testTest() {
        let re1 = RegExp("abc")
        XCTAssertTrue(re1!.test(abcs))
        XCTAssertFalse(re1!.test(emojis))
        XCTAssertFalse(re1!.test(qbfjold))
        
        let re2 = RegExp("ab+c")
        XCTAssertTrue(re2!.test(abcs))
        XCTAssertFalse(re2!.test(emojis))
        XCTAssertFalse(re2!.test(qbfjold))
        
        let re4 = RegExp("🐼")
        XCTAssertFalse(re4!.test(abcs))
        XCTAssertTrue(re4!.test(emojis))
        XCTAssertFalse(re4!.test(qbfjold))
        
        let re5 = RegExp("fox jumps over", ignoreCase: true)
        XCTAssertFalse(re5!.test(abcs))
        XCTAssertFalse(re5!.test(emojis))
        XCTAssertTrue(re5!.test(qbfjold))
    }
}

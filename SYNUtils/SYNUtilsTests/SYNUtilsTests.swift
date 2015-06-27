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

class CGRectTests: XCTestCase {
    let fourFifthsRect = CGRectMake(0, 0, 4, 5)
    let cinemaRect = CGRectMake(0, 0, 16, 9)
    let square100Rect = CGRectMake(0, 0, 100, 100)
    
    func testAspectFill() {
        let scaled1 = fourFifthsRect.aspectFill(square100Rect)
        XCTAssertEqual(0, scaled1.origin.x)
        XCTAssertEqual(-12.5, scaled1.origin.y)
        XCTAssertEqual(100, scaled1.size.width)
        XCTAssertEqual(125, scaled1.size.height)
        
        let scaled2 = square100Rect.aspectFill(fourFifthsRect)
        XCTAssertEqual(-0.5, scaled2.origin.x)
        XCTAssertEqual(0, scaled2.origin.y)
        XCTAssertEqual(5, scaled2.size.width)
        XCTAssertEqual(5, scaled2.size.height)
    }
    
    func testAspectFit() {
        let scaled1 = fourFifthsRect.aspectFit(square100Rect)
        XCTAssertEqual(10, scaled1.origin.x)
        XCTAssertEqual(0, scaled1.origin.y)
        XCTAssertEqual(80, scaled1.size.width)
        XCTAssertEqual(100, scaled1.size.height)
        
        let scaled2 = square100Rect.aspectFit(fourFifthsRect)
        XCTAssertEqual(0, scaled2.origin.x)
        XCTAssertEqual(0.5, scaled2.origin.y)
        XCTAssertEqual(4, scaled2.size.width)
        XCTAssertEqual(4, scaled2.size.height)
    }
}

class NSObjectTests: XCTestCase {
    private static var key = "testPropertyKey"
    var testProperty: String? {
        get { return getAssociatedObject(&NSObjectTests.key) as? String }
        set { setAssociatedObject(&NSObjectTests.key, newValue as NSString?) }
    }
    
    func testGetSetAssociatedObject() {
        XCTAssertNil(testProperty)
        testProperty = "test"
        XCTAssertEqual("test", testProperty!)
        testProperty = nil
        XCTAssertNil(testProperty)
    }
}

class NSRegularExpressionTests: XCTestCase {
    let abcdef = "abcdef"
    let emojis = "👹🇪🇸👀🐼📱"
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
        let matches1 = re1!.exec(abcdef)
        XCTAssertEqual(matches1.input, abcdef)
        XCTAssertEqual(count(abcdef), matches1.count)
        for match in matches1 {
            XCTAssertEqual(0, match.captureGroups.count)
        }
        XCTAssertEqual(matches1[0].value, "a")
        XCTAssertEqual(matches1[1].value, "b")
        XCTAssertEqual(matches1[2].value, "c")
        XCTAssertEqual(matches1[3].value, "d")
        XCTAssertEqual(matches1[4].value, "e")
        XCTAssertEqual(matches1[5].value, "f")
        XCTAssertEqual(abcdef.substringWithRange(matches1[0].range), "a")
        XCTAssertEqual(abcdef.substringWithRange(matches1[1].range), "b")
        XCTAssertEqual(abcdef.substringWithRange(matches1[2].range), "c")
        XCTAssertEqual(abcdef.substringWithRange(matches1[3].range), "d")
        XCTAssertEqual(abcdef.substringWithRange(matches1[4].range), "e")
        XCTAssertEqual(abcdef.substringWithRange(matches1[5].range), "f")
        
        let re2 = RegExp("(.)(.)(.)")
        let matches2 = re2!.exec(abcdef)
        XCTAssertEqual(matches2.input, abcdef)
        XCTAssertEqual(count(abcdef) / 3, matches2.count)
        XCTAssertEqual("abc", matches2[0].value)
        XCTAssertEqual("def", matches2[1].value)
        XCTAssertEqual(abcdef.substringWithRange(matches2[0].range), "abc")
        XCTAssertEqual(abcdef.substringWithRange(matches2[1].range), "def")
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
        XCTAssertEqual(emojis.substringWithRange(matches3[0].range), "🐼")
    }
    
    func testTest() {
        let re1 = RegExp("abc")
        XCTAssertTrue(re1!.test(abcdef))
        XCTAssertFalse(re1!.test(emojis))
        XCTAssertFalse(re1!.test(qbfjold))
        
        let re2 = RegExp("ab+c")
        XCTAssertTrue(re2!.test(abcdef))
        XCTAssertFalse(re2!.test(emojis))
        XCTAssertFalse(re2!.test(qbfjold))
        
        let re4 = RegExp("🐼")
        XCTAssertFalse(re4!.test(abcdef))
        XCTAssertTrue(re4!.test(emojis))
        XCTAssertFalse(re4!.test(qbfjold))
        
        let re5 = RegExp("fox jumps over", ignoreCase: true)
        XCTAssertFalse(re5!.test(abcdef))
        XCTAssertFalse(re5!.test(emojis))
        XCTAssertTrue(re5!.test(qbfjold))
    }
}

class NSStringTests: XCTestCase {
    let abcdef = "abcdef"
    let emojis = "👹🇪🇸👀🐼📱"
    
    func testSubscript() {
        XCTAssertEqual("a", abcdef[0])
        XCTAssertEqual("b", abcdef[1])
        XCTAssertEqual("c", abcdef[2])
        XCTAssertEqual("d", abcdef[3])
        XCTAssertEqual("e", abcdef[4])
        XCTAssertEqual("f", abcdef[5])
        
        XCTAssertEqual("👹", emojis[0])
        XCTAssertEqual("🇪🇸", emojis[1])
        XCTAssertEqual("👀", emojis[2])
        XCTAssertEqual("🐼", emojis[3])
        XCTAssertEqual("📱", emojis[4])
        
        XCTAssertEqual("abc", abcdef[0...2])
        XCTAssertEqual("def", abcdef[3..<6])
        
        XCTAssertEqual("👹🇪🇸👀", emojis[0..<3])
        XCTAssertEqual("🐼📱", emojis[3...4])
    }
}

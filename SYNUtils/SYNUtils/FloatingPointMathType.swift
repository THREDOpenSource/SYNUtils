//
//  FloatingPointMathType.swift
//  SYNUtils
//
//  Created by John Hurliman on 6/28/15.
//  Copyright (c) 2015 Syntertainment. All rights reserved.
//

import Foundation
import CoreGraphics

public protocol FloatingPointMathType {
    var abs: Self {get}
    var acos: Self {get}
    var asin: Self {get}
    var atan: Self {get}
    func atan2(x: Self) -> Self
    var cos: Self {get}
    var sin: Self {get}
    var tan: Self {get}
    var exp: Self {get}
    var exp2: Self {get}
    func lerp(a: Self, _ b: Self, t: Self) -> Self
    var log: Self {get}
    var log10: Self {get}
    var log2: Self {get}
    func pow(exponent: Self) -> Self
    var sqrt: Self {get}
    var floor: Self {get}
    var ceil: Self {get}
    var round: Self {get}
    func clamp(min: Self, _ max: Self) -> Self
}

extension CGFloat: FloatingPointMathType {
    public static func random(min: CGFloat, _ max: CGFloat) -> CGFloat {
        let diff = max - min
        let rand = Double(arc4random_uniform(UInt32(RAND_MAX)))
        return CGFloat((rand / Double(RAND_MAX)) * Double(diff)) + min
    }
    
    public var abs:CGFloat      { return CGFloat.abs(self) }
    public var acos:CGFloat     { return CoreGraphics.acos(self) }
    public var asin:CGFloat     { return CoreGraphics.asin(self) }
    public var atan:CGFloat     { return CoreGraphics.atan(self) }
    public func atan2(x: CGFloat) -> CGFloat { return CoreGraphics.atan2(self, x) }
    public var cos:CGFloat      { return CoreGraphics.cos(self) }
    public var sin:CGFloat      { return CoreGraphics.sin(self) }
    public var tan:CGFloat      { return CoreGraphics.tan(self) }
    public var exp:CGFloat      { return CoreGraphics.exp(self) }
    public var exp2:CGFloat     { return CoreGraphics.exp2(self) }
    public func lerp(a: CGFloat, _ b: CGFloat, t: CGFloat) -> CGFloat { return a + (b - a) * t }
    public var log:CGFloat      { return CoreGraphics.log(self) }
    public var log10:CGFloat    { return CoreGraphics.log10(self) }
    public var log2:CGFloat     { return CoreGraphics.log2(self) }
    public func pow(exponent: CGFloat) -> CGFloat { return CoreGraphics.pow(self, exponent) }
    public var sqrt:CGFloat     { return CoreGraphics.sqrt(self) }
    public var floor: CGFloat   { return CoreGraphics.floor(self) }
    public var ceil: CGFloat    { return CoreGraphics.ceil(self) }
    public var round: CGFloat   { return CoreGraphics.round(self) }
    public func clamp(min: CGFloat, _ max: CGFloat) -> CGFloat {
        return Swift.max(min, Swift.min(max, self))
    }
}

extension Float: FloatingPointMathType {
    public static func random(min: Float, _ max: Float) -> Float {
        let min = Double(min)
        let max = Double(max)
        let diff = max - min
        let rand = Double(arc4random_uniform(UInt32(RAND_MAX)))
        return Float(((rand / Double(RAND_MAX)) * diff) + min)
    }
    
    public var abs: Float   { return Float.abs(self) }
    public var acos: Float  { return Foundation.acos(self) }
    public var asin: Float  { return Foundation.asin(self) }
    public var atan: Float  { return Foundation.atan(self) }
    public func atan2(x: Float) -> Float { return Foundation.atan2(self, x) }
    public var cos: Float   { return Foundation.cos(self) }
    public var sin: Float   { return Foundation.sin(self) }
    public var tan: Float   { return Foundation.tan(self) }
    public var exp: Float   { return Foundation.exp(self) }
    public var exp2: Float  { return Foundation.exp2(self) }
    public func lerp(a: Float, _ b: Float, t: Float) -> Float { return a + (b - a) * t }
    public var log: Float   { return Foundation.log(self) }
    public var log10: Float { return Foundation.log10(self) }
    public var log2: Float  { return Foundation.log2(self) }
    public func pow(exponent: Float) -> Float { return Foundation.pow(self, exponent) }
    public var sqrt: Float  { return Foundation.sqrt(self) }
    public var floor: Float { return Foundation.floor(self) }
    public var ceil: Float  { return Foundation.ceil(self) }
    public var round: Float { return Foundation.round(self) }
    public func clamp(min: Float, _ max: Float) -> Float {
        return Swift.max(min, Swift.min(max, self))
    }
}

extension Double: FloatingPointMathType {
    public static func random(min: Double, _ max: Double) -> Double {
        let diff = max - min
        let rand = Double(arc4random_uniform(UInt32(RAND_MAX)))
        return ((rand / Double(RAND_MAX)) * diff) + min
    }
    
    public var abs: Double   { return Double.abs(self) }
    public var acos: Double  { return Foundation.acos(self) }
    public var asin: Double  { return Foundation.asin(self) }
    public var atan: Double  { return Foundation.atan(self) }
    public func atan2(x: Double) -> Double { return Foundation.atan2(self, x) }
    public var cos: Double   { return Foundation.cos(self) }
    public var sin: Double   { return Foundation.sin(self) }
    public var tan: Double   { return Foundation.tan(self) }
    public var exp: Double   { return Foundation.exp(self) }
    public var exp2: Double  { return Foundation.exp2(self) }
    public func lerp(a: Double, _ b: Double, t: Double) -> Double { return a + (b - a) * t }
    public var log: Double   { return Foundation.log(self) }
    public var log10: Double { return Foundation.log10(self) }
    public var log2: Double  { return Foundation.log2(self) }
    public func pow(exponent: Double) -> Double { return Foundation.pow(self, exponent) }
    public var sqrt: Double  { return Foundation.sqrt(self) }
    public var floor: Double { return Foundation.floor(self) }
    public var ceil: Double  { return Foundation.ceil(self) }
    public var round: Double { return Foundation.round(self) }
    public func clamp(min: Double, _ max: Double) -> Double {
        return Swift.max(min, Swift.min(max, self))
    }
}

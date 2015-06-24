//
//  Threading.swift
//  SYNUtils
//
//  Created by John Hurliman on 6/23/15.
//  Copyright (c) 2015 Syntertainment. All rights reserved.
//

import Foundation

public func runOnMainThread(block: dispatch_block_t) {
    dispatch_async(dispatch_get_main_queue(), block)
}

public func runAsync(block: dispatch_block_t) {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
}

public func runOnMainThreadIfNeeded(block: dispatch_block_t) {
    if NSThread.currentThread().isMainThread {
        block()
    } else {
        runOnMainThread(block)
    }
}

public func runOnMainThreadIfNeededSync(block: dispatch_block_t) {
    if (NSThread.currentThread().isMainThread) {
        block()
    } else {
        dispatch_sync(dispatch_get_main_queue(), block)
    }
}

public func runOnMainThreadAfterDelay(block: dispatch_block_t, delay: NSTimeInterval) {
    let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
    let queue = dispatch_get_main_queue()
    dispatch_after(time, queue, block)
}

public func runAsyncAfterDelay(block: dispatch_block_t, delay: NSTimeInterval) {
    let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
    let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
    dispatch_after(time, queue, block)
}

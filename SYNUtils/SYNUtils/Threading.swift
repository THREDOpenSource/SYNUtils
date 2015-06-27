//
//  Threading.swift
//  SYNUtils
//
//  Created by John Hurliman on 6/23/15.
//  Copyright (c) 2015 Syntertainment. All rights reserved.
//

import Foundation

/// Retrieve a thread-local object that is lazily initialized. A new
/// thread-local object is instantiated and cached for each thread this method
/// is called on.
///
/// :param: key Key used to store the thread-local being retrieved
/// :param: initializer Function that instantiates the thread-local object
///   This method is run only once per thread, the first time the object is
///   accessed on each thread
public func lazyThreadLocalObject<T: AnyObject>(key: String, initializer: () -> T) -> T {
    let threadDictionary = NSThread.currentThread().threadDictionary
    return threadDictionary[key] as? T ?? {
        let obj = initializer()
        threadDictionary[key] = obj
        return obj
    }()
}

/// Asynchronously schedule a function for execution on the main thread
///
/// :param: block Function to run on the main thread in the (near) future
public func runOnMainThread(block: dispatch_block_t) {
    dispatch_async(dispatch_get_main_queue(), block)
}

/// Asynchronously schedule a function for execution on the main thread if we're
/// currently on a background thread, otherwise synchronously run the function
/// immediately.
///
/// :param: block Function to either asynchronously schedule or run immediately
public func runOnMainThreadIfNeeded(block: dispatch_block_t) {
    if NSThread.currentThread().isMainThread {
        block()
    } else {
        runOnMainThread(block)
    }
}

/// Schedule a function for execution on the main thread and block execution on
/// the current background thread until it completes, or synchronously run the
/// function immediately if we're already on the main thread.
///
/// :param: block Function to either synchronously schedule or run immediately
public func runOnMainThreadIfNeededSync(block: dispatch_block_t) {
    if (NSThread.currentThread().isMainThread) {
        block()
    } else {
        dispatch_sync(dispatch_get_main_queue(), block)
    }
}

/// Asynchronously schedule a function for execution on the main thread after at
/// least the given delay.
///
/// :param: delay Minimum number of seconds to wait before execution
/// :param: block Function to run on the main thread in the future
public func runOnMainThreadAfterDelay(delay: NSTimeInterval, block: dispatch_block_t) {
    let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
    let queue = dispatch_get_main_queue()
    dispatch_after(time, queue, block)
}

/// Asynchronously schedule a function for execution on a background thread,
/// using the default priority global queue.
///
/// :param: block Function to run on a background thread in the (near) future
public func runAsync(block: dispatch_block_t) {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
}

/// Asynchronously schedule a function for execution on a background thread
/// after at least the given delay, using the default priority global queue.
///
/// :param: delay Minimum number of seconds to wait before execution
/// :param: block Function to run on a background thread in the future
public func runAsyncAfterDelay(delay: NSTimeInterval, block: dispatch_block_t) {
    let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
    let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
    dispatch_after(time, queue, block)
}

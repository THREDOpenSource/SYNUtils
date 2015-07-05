//
//  UIView+Utils.swift
//  SYNUtils
//
//  Created by John Hurliman on 7/5/15.
//  Copyright (c) 2015 Syntertainment. All rights reserved.
//

#if os(iOS)
    import UIKit
#else
    import AppKit
    public typealias UIView = NSView
#endif

extension UIView {
#if DEBUG
    private static var once = dispatch_once_t()
    
    override public class func initialize() {
        // Swizzle layout/display methods in the UIView static initializer
        dispatch_once(&once) {
            method_exchangeImplementations(
                class_getInstanceMethod(UIView.self, Selector("setNeedsLayout")),
                class_getInstanceMethod(UIView.self, Selector("synutils_setNeedsLayout"))
            )
            
            method_exchangeImplementations(
                class_getInstanceMethod(UIView.self, Selector("setNeedsDisplay")),
                class_getInstanceMethod(UIView.self, Selector("synutils_setNeedsDisplay"))
            )
            
            method_exchangeImplementations(
                class_getInstanceMethod(UIView.self, Selector("setNeedsDisplayInRect:")),
                class_getInstanceMethod(UIView.self, Selector("synutils_setNeedsDisplayInRect:"))
            )
        }
    }
    
    func assertIfNotMainThread() {
        // Some parts of UIKit can safely be used in background threads. Only
        // consider UIViews attached to a UIWindow
        if self.window == nil { return }
        
        // Check if we are on the main thread
        let isMainThread = NSThread.isMainThread()
        if isMainThread { return }
        
        // Check if we're running on a background queue created by UIKit
        let curQueueLabel = String.fromCString(dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL))
        if "UIKit" == curQueueLabel { return }
        
        assert(isMainThread, "\nERROR: All calls to UIKit need to happen on the main thread. " +
            "Use runOnMainThread if you're unsure what thread you're in.\n\nStacktrace: " +
            "\(NSThread.callStackSymbols())")
    }
    
    // MARK: - Swizzled Methods
    
    func synutils_setNeedsLayout() {
        assertIfNotMainThread()
        synutils_setNeedsLayout()
    }
    
    func synutils_setNeedsDisplay() {
        assertIfNotMainThread()
        synutils_setNeedsDisplay()
    }
    
    func synutils_setNeedsDisplayInRect(rect: CGRect) {
        assertIfNotMainThread()
        synutils_setNeedsDisplayInRect(rect)
    }
#endif
    
    // MARK: AppKit Polyfills
    
#if !os(iOS)
    public override func viewDidMoveToWindow() {
        didMoveToWindow()
    }
    
    public func didMoveToWindow() {
        super.viewDidMoveToWindow()
    }
    
    public override func viewDidMoveToSuperview() {
        didMoveToSuperview()
    }
    
    public func didMoveToSuperview() {
        super.viewDidMoveToSuperview()
    }
    
    public override func layout() {
        layoutSubviews()
    }
    
    public func layoutSubviews() {
        super.layout()
    }
#endif
}

//
//  StartupView.swift
//  Scott Fitsimones
//
//  Created by Scott Fitsimones on 4/19/15.
//  Copyright (c) 2015 Bolt Visual. All rights reserved.
//

import Cocoa

class StartupView: NSView {

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        let newLayer = CALayer()
        newLayer.backgroundColor =  CGColorCreateGenericRGB(1, 1, 1, 0.8)
        self.wantsLayer = true
        self.layer = newLayer
        //self.layer?.opacity = 0
        let frame = NSScreen.mainScreen()?.frame as CGRect?
        self.frame = frame!
        // Drawing code here.

    }
    
    override func hitTest(aPoint: NSPoint) -> NSView? {
        return self.superview
    }
}
